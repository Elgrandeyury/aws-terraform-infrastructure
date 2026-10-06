variable "name" {
  description = "Name prefix for compute resources."
  type        = string
}

variable "subnet_ids" {
  description = "Private application subnet IDs used by the Auto Scaling Group."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to application instances."
  type        = list(string)
}

variable "target_group_arns" {
  description = "Target groups attached to the Auto Scaling Group."
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for application nodes."
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of instances."
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired number of instances."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances."
  type        = number
  default     = 4
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
