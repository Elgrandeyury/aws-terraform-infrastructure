variable "aws_region" {
  description = "AWS region used for the deployment."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name used for AWS resource tags."
  type        = string
  default     = "aws-terraform-infrastructure"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type used for the demo web server."
  type        = string
  default     = "t3.micro"
}
