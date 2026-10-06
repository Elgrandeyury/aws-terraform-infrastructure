variable "aws_region" {
  description = "AWS region for the development environment."
  type        = string
  default     = "me-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tags."
  type        = string
  default     = "advanced-web-platform"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Two Availability Zones for the environment."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDRs for private application subnets."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "data_subnet_cidrs" {
  description = "CIDRs for private data subnets."
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type used by the application Auto Scaling Group."
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 application instances."
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 application instances."
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of EC2 application instances."
  type        = number
  default     = 4
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "database_name" {
  description = "Initial PostgreSQL database name."
  type        = string
  default     = "appdb"
}

variable "db_master_username" {
  description = "Master username for PostgreSQL. The password is generated and managed by AWS Secrets Manager."
  type        = string
  default     = "dbadmin"
}

variable "db_allocated_storage" {
  description = "Initial RDS storage allocation in GiB."
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum RDS storage allocation for storage autoscaling."
  type        = number
  default     = 100
}
