################### Load Balancer Target Group ###################
resource "aws_lb_target_group" "jenkins_tg" {
  name        = "${var.project}-${var.environment}-tg"
  port        = var.lb_port
  protocol    = var.lb_protocol
  target_type = var.lb_target_type
  vpc_id      = data.aws_vpc.default.id

  health_check {
    interval            = var.lb_healthcheck_interval
    path                = "/"
    protocol            = var.lb_protocol
    timeout             = var.lb_healthcheck_timeout
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_threshold
  }
}

################### Application Load Balancer ###################
resource "aws_lb" "jenkins_alb" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = var.lb_internal
  ip_address_type    = var.lb_address_type
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.jenkins_alb.id]
  subnets            = data.aws_subnet_ids.subnet.ids
  tags = {
    "Name" = "${var.project}_${var.environment}_alb"
  }
}

################### Load Balancer Listener ###################
resource "aws_lb_listener" "jenkins_alb_listner" {
  load_balancer_arn = aws_lb.jenkins_alb.arn
  port              = var.lb_port
  protocol          = var.lb_protocol

  default_action {
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
    type             = "forward"
  }
}

################### Attach Target Group to Application Load Balancer ###################
resource "aws_lb_target_group_attachment" "jenkins_tg_attach" {
  count            = length(aws_instance.jenkins_master)
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = aws_instance.jenkins_master[count.index].id
}
