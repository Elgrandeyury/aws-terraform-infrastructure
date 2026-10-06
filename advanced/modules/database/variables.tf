variable "name" {
  description = "Name prefix for database resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the database security group is created."
  type        = string
}

variable "data_subnet_ids" {
  description = "Private data subnet IDs used by the DB subnet group."
  type        = list(string)

  validation {
    condition     = length(var.data_subnet_ids) >= 2
    error_message = "At least two data subnets are required for a Multi-AZ database design."
  }
}

variable "app_security_group_id" {
  description = "Security group allowed to connect to the database."
  type        = string
}

variable "engine" {
  description = "RDS database engine."
  type        = string
  default     = "postgres"
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "database_name" {
  description = "Initial database name."
  type        = string
  default     = "appdb"
}

variable "master_username" {
  description = "Master database username. Password is managed by AWS Secrets Manager."
  type        = string
  default     = "dbadmin"
}

variable "allocated_storage" {
  description = "Initial storage allocation in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage allocation for RDS storage autoscaling."
  type        = number
  default     = 100
}

variable "multi_az" {
  description = "Whether to deploy the RDS instance in Multi-AZ mode."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Protect the database from accidental deletion."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip a final snapshot when deleting the database. Suitable for the dev environment only."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
