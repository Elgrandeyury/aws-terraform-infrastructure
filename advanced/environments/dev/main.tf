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

module "compute" {
  source = "../../modules/compute"

  name               = var.project_name
  subnet_ids         = module.networking.app_subnet_ids
  security_group_ids = [module.load_balancer.app_security_group_id]
  target_group_arns  = [module.load_balancer.target_group_arn]

  instance_type    = var.instance_type
  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_capacity
  max_size         = var.asg_max_size

  tags = {
    Environment = "dev"
    Portfolio   = "true"
  }
}

module "database" {
  source = "../../modules/database"

  name                  = var.project_name
  vpc_id                = module.networking.vpc_id
  data_subnet_ids       = module.networking.data_subnet_ids
  app_security_group_id = module.load_balancer.app_security_group_id

  engine                = "postgres"
  instance_class        = var.db_instance_class
  database_name         = var.database_name
  master_username       = var.db_master_username
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  multi_az              = true
  deletion_protection   = false
  skip_final_snapshot   = true

  tags = {
    Environment = "dev"
    Portfolio   = "true"
  }
}

module "storage" {
  source = "../../modules/storage"

  name                  = var.project_name
  vpc_id                = module.networking.vpc_id
  subnet_ids            = module.networking.app_subnet_ids
  app_security_group_id = module.load_balancer.app_security_group_id

  tags = {
    Environment = "dev"
    Portfolio   = "true"
  }
}
