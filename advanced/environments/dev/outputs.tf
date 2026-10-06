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
