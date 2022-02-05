data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "jenkins_master" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.jenkins.name, aws_security_group.jenkins_remote.name]
  key_name        = var.key_name
  count           = 1
  user_data       = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    printf "[daemonize]\nbaseurl=https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/\ngpgcheck=no\nenabled=yes" >> /etc/yum.repos.d/epelfordaemonize.repo
    sudo yum install daemonize -y
    sudo yum install jenkins -y
    sudo yum install jenkins java-1.8.0-openjdk-devel -y
    sudo yum install openssh-server -y
    sudo service jenkins start
    sudo -su jenkins
    ssh-keygen -q -t rsa -b 4096 -C "jenkins-master" -N '' -f /var/lib/jenkins/.ssh/id_rsa
    EOF

  tags = {
    Application = "${var.project}"
    Environment = "${var.environment}"
    Name        = "${var.project}_master_${count.index}"
    OS          = "Linux"
    Purpose     = "Host Jenkins Master Node"
    Source      = "Terraform"
  }
}

resource "aws_instance" "jenkins_slaves" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.jenkins_remote.name]
  key_name        = var.key_name
  count           = 2
  user_data       = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install java-1.8.0-openjdk-devel -y
    sudo yum install openssh-server -y
    EOF

  tags = {
    Application = "${var.project}"
    Environment = "${var.environment}"
    Name        = "${var.project}_slave_${count.index}"
    OS          = "Linux"
    Purpose     = "Host Jenkins Slave Node"
    Source      = "Terraform"
  }
}
