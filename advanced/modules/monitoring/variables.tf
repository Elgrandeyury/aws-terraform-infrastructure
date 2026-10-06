variable "name" {
  description = "Name prefix for monitoring resources."
  type        = string
}

variable "autoscaling_group_name" {
  description = "Auto Scaling Group name to monitor."
  type        = string
}

variable "db_instance_identifier" {
  description = "RDS DB instance identifier to monitor."
  type        = string
}

variable "minimum_in_service_instances" {
  description = "Minimum healthy instances expected in the Auto Scaling Group."
  type        = number
  default     = 2
}

variable "db_free_storage_threshold_bytes" {
  description = "Alarm threshold for low RDS free storage in bytes."
  type        = number
  default     = 5368709120
}

variable "tags" {
  description = "Additional tags applied to monitoring resources."
  type        = map(string)
  default     = {}
}
