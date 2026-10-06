output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "IDs of the private application subnets."
  value       = aws_subnet.app[*].id
}

output "data_subnet_ids" {
  description = "IDs of the private data subnets."
  value       = aws_subnet.data[*].id
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways."
  value       = aws_nat_gateway.this[*].id
}

output "availability_zones" {
  description = "Availability Zones used by the module."
  value       = var.availability_zones
}
