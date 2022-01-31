################### SSH Connect Security Group ###################
resource "aws_security_group" "jenkins_remote" {
  name        = "${var.project}_${var.environment}_remote_sg"
  description = "Security group for ${var.project}_${var.environment}_remote"
}

resource "aws_security_group_rule" "jenkins_remote_22" {
  description       = "Allow TCP/22 to Jenkins Server"
  type              = "ingress"
  cidr_blocks       = var.sg_ip_address
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.jenkins_remote.id
}

################### Jenkins Server Security Group ###################
resource "aws_security_group" "jenkins" {
  name        = "${var.project}_${var.environment}_sg"
  description = "Security group for ${var.project}_${var.environment}"

}

resource "aws_security_group_rule" "jenkins_ingress_alb_8080" {
  description              = "Allow TCP/8080 from Load Balancer"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins.id
  source_security_group_id = aws_security_group.jenkins_alb.id
}

################### Load Balancer Security Group ###################
resource "aws_security_group" "jenkins_alb" {
  name        = "${var.project}_${var.environment}_alb_sg"
  description = "Security group for ${var.project}_${var.environment}_alb"
}

resource "aws_security_group_rule" "alb_ingress_all_http" {
  description       = "Allow TCP/80 from Internet"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.jenkins_alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_jenkins_8080" {
  description              = "Allow TCP/8080 to jenkins"
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.jenkins_alb.id
  source_security_group_id = aws_security_group.jenkins.id
}

resource "aws_security_group_rule" "alb_egress_all_http" {
  description       = "Allow TCP/80 to Internet"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "-1"
  security_group_id = aws_security_group.jenkins.id
}

