output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "app_subnet_ids" {
  value = module.networking.app_subnet_ids
}

output "data_subnet_ids" {
  value = module.networking.data_subnet_ids
}

output "nat_gateway_ids" {
  value = module.networking.nat_gateway_ids
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}

output "alb_security_group_id" {
  value = module.load_balancer.alb_security_group_id
}

output "app_security_group_id" {
  value = module.load_balancer.app_security_group_id
}

output "autoscaling_group_name" {
  value = module.compute.autoscaling_group_name
}

output "launch_template_id" {
  value = module.compute.launch_template_id
}

output "compute_iam_role_name" {
  value = module.compute.iam_role_name
}

output "db_endpoint" {
  value = module.database.db_endpoint
}

output "db_port" {
  value = module.database.db_port
}

output "db_security_group_id" {
  value = module.database.db_security_group_id
}

output "db_master_secret_arn" {
  value     = module.database.master_user_secret_arn
  sensitive = true
}
