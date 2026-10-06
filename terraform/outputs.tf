output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 web server."
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "HTTP URL for the demo Nginx page."
  value       = "http://${aws_instance.web.public_ip}"
}
