variable "project" {
  type        = string
  description = "Set the project name."
}

variable "environment" {
  type        = string
  description = "Set the environment name."
}

variable "name" {
  type        = string
  description = "Set a common name used for resources."
  default     = "jenkins"
}

variable "region" {
  type        = string
  description = "Set the region for AWS VPC."
  default     = "af-south-1"
}

variable "instance_type" {
  type        = string
  description = "Set the EC2 instance type to be used for the chosen region."
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Set the Key Pair name used for authenticating SSH connection into EC2 instances."
  default     = "AfKeyPair"
}

variable "sg_ip_address" {
  type        = list(any)
  description = "Set the list of whitelisted IP addresses to access EC2 instance via SSH."
}

variable "lb_port" {
  type        = string
  description = "Set the port to listen on for the Load Balancer."
  default     = "8080"
}

variable "lb_protocol" {
  type        = string
  description = "Set the protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL."
  default     = "HTTP"
}

variable "lb_target_type" {
  type        = string
  description = "Set the Load Balancer target type."
  default     = "instance"
}

variable "lb_healthcheck_interval" {
  type        = string
  description = "Set the interval between checks."
  default     = 30
}

variable "lb_healthcheck_timeout" {
  type        = string
  description = "Set the length of time before the check times out."
  default     = 10
}

variable "lb_healthy_threshold" {
  type        = string
  description = "Set the number of checks before the instance is declared health."
  default     = 3
}

variable "lb_unhealthy_threshold" {
  type        = string
  description = "Set the number of checks before the instance is declared unhealthy."
  default     = 2
}

variable "lb_internal" {
  type        = string
  description = "If true, Load Balancer will be an internal Load Balancer."
  default     = false
}

variable "lb_address_type" {
  type        = string
  description = "Set the Internet Protocol version."
  default     = "ipv4"
}

variable "lb_type" {
  type        = string
  description = "Set the type of Load Balancer."
  default     = "application"
}
