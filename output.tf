output "alb_dns_name" {
  value = aws_lb.jenkins_alb.dns_name
}

output "jenkins_master_public_ip" {
  value = aws_instance.jenkins_master.*.public_ip
}

output "jenkins_slave_public_ip" {
  value = aws_instance.jenkins_slaves.*.public_ip
}
