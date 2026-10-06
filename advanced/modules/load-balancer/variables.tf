variable "name" {
  description = "Name prefix for load balancer resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer and security groups are created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the Application Load Balancer."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "At least two public subnets are required for the ALB."
  }
}

variable "listener_port" {
  description = "Public HTTP listener port."
  type        = number
  default     = 80
}

variable "target_port" {
  description = "Port used by the application targets."
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "HTTP path used for target health checks."
  type        = string
  default     = "/"
}

variable "domain_name" {
  description = "Optional application DNS name. When set with route53_zone_name, ACM HTTPS and Route53 aliasing are enabled."
  type        = string
  default     = null
  nullable    = true
}

variable "route53_zone_name" {
  description = "Optional existing public Route53 hosted zone name, for example example.com."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
