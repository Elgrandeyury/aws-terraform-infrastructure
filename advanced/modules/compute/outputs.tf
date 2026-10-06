output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}

output "launch_template_id" {
  description = "ID of the EC2 Launch Template."
  value       = aws_launch_template.this.id
}

output "instance_profile_name" {
  description = "IAM instance profile attached to EC2 instances."
  value       = aws_iam_instance_profile.ec2.name
}

output "iam_role_name" {
  description = "IAM role attached to application EC2 instances."
  value       = aws_iam_role.ec2.name
}
