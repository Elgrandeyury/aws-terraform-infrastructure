module "networking" {
  source = "../../modules/networking"

  name                = var.project_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  app_subnet_cidrs    = var.app_subnet_cidrs
  data_subnet_cidrs   = var.data_subnet_cidrs

  tags = {
    Environment = "dev"
    Portfolio   = "true"
  }
}

module "load_balancer" {
  source = "../../modules/load-balancer"

  name              = var.project_name
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids

  listener_port     = 80
  target_port       = 80
  health_check_path = "/"

  tags = {
    Environment = "dev"
    Portfolio   = "true"
  }
}
