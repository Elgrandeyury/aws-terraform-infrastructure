variable "name" {
  description = "Name prefix for storage resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EFS security group is created."
  type        = string
}

variable "subnet_ids" {
  description = "Private application subnet IDs used for EFS mount targets."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnets are required for high-availability EFS mount targets."
  }
}

variable "app_security_group_id" {
  description = "Application security group allowed to access EFS over NFS."
  type        = string
}

variable "tags" {
  description = "Additional tags applied to storage resources."
  type        = map(string)
  default     = {}
}
