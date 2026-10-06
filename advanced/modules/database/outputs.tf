output "db_endpoint" {
  description = "RDS endpoint for application connectivity."
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "RDS hostname without the port."
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Database listener port."
  value       = aws_db_instance.this.port
}

output "db_instance_arn" {
  description = "ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}

output "db_security_group_id" {
  description = "Security group protecting the database tier."
  value       = aws_security_group.database.id
}

output "master_user_secret_arn" {
  description = "AWS Secrets Manager ARN for the RDS-managed master password."
  value       = try(aws_db_instance.this.master_user_secret[0].secret_arn, null)
  sensitive   = true
}
