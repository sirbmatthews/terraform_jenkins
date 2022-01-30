variable "project" {
  type        = string
  description = "The project name"
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "name" {
  type        = string
  description = "A common name used for resources"
  default     = "jenkins"
}

variable "region" {
  type        = string
  description = "The region for AWS VPC"
  default     = "af-south-1"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type to be used for the selected region"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "The authentication key name that allows SSH connection into an EC2 instance"
  default     = "AfKeyPair"
}

variable "lb_port" {
  type        = string
  description = "The port to listen on for the load balancer"
  default     = "8080"
}

variable "lb_protocol" {
  type        = string
  description = "The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL"
  default     = "HTTP"
}

variable "lb_target_type" {
  type        = string
  description = "The laod balancer target type"
  default     = "instance"
}

variable "lb_healthcheck_interval" {
  type        = string
  description = "The interval between checks"
  default     = 30
}

variable "lb_healthcheck_timeout" {
  type        = string
  description = "The length of time before the check times out"
  default     = 10
}

variable "lb_healthy_threshold" {
  type        = string
  description = "The number of checks before the instance is declared health"
  default     = 3
}

variable "lb_unhealthy_threshold" {
  type        = string
  description = "The number of checks before the instance is declared unhealthy"
  default     = 2
}

variable "lb_internal" {
  type        = string
  description = "If true, LB will be an internal LB"
  default     = false
}

variable "lb_address_type" {
  type        = string
  description = "ipv4 or ipv6"
  default     = "ipv4"
}

variable "lb_type" {
  type        = string
  description = "The type of load balancer"
  default     = "application"
}