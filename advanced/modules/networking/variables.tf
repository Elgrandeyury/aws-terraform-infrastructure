variable "name" {
  description = "Name prefix used for networking resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Two Availability Zones used by the architecture."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Exactly two Availability Zones must be supplied."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly two public subnet CIDRs must be supplied."
  }
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for the private application subnets."
  type        = list(string)

  validation {
    condition     = length(var.app_subnet_cidrs) == 2
    error_message = "Exactly two application subnet CIDRs must be supplied."
  }
}

variable "data_subnet_cidrs" {
  description = "CIDR blocks for the private data subnets."
  type        = list(string)

  validation {
    condition     = length(var.data_subnet_cidrs) == 2
    error_message = "Exactly two data subnet CIDRs must be supplied."
  }
}

variable "tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}
