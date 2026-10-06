output "alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the ALB."
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "ARN of the application target group."
  value       = aws_lb_target_group.app.arn
}

output "alb_security_group_id" {
  description = "Security group ID attached to the ALB."
  value       = aws_security_group.alb.id
}

output "app_security_group_id" {
  description = "Security group ID intended for application instances."
  value       = aws_security_group.app.id
}

output "https_enabled" {
  description = "Whether Route53 + ACM HTTPS is enabled."
  value       = local.https_enabled
}

output "application_url" {
  description = "Preferred application URL."
  value       = local.https_enabled ? "https://${var.domain_name}" : "http://${aws_lb.this.dns_name}"
}

output "certificate_arn" {
  description = "ACM certificate ARN when HTTPS is enabled."
  value       = local.https_enabled ? aws_acm_certificate.this[0].arn : null
}
