locals {
  common_tags = merge(
    {
      Project   = var.name
      ManagedBy = "Terraform"
      Layer     = "database"
    },
    var.tags
  )
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.data_subnet_ids

  tags = merge(local.common_tags, {
    Name = "${var.name}-db-subnets"
  })
}

resource "aws_security_group" "database" {
  name        = "${var.name}-db-sg"
  description = "Allow PostgreSQL access only from the application security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from application tier"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.name}-db-sg"
  })
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}-db"

  engine         = var.engine
  instance_class = var.instance_class

  db_name  = var.database_name
  username = var.master_username

  manage_master_user_password = true

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  multi_az               = var.multi_az
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.database.id]

  backup_retention_period = 7
  copy_tags_to_snapshot    = true

  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  auto_minor_version_upgrade = true

  tags = merge(local.common_tags, {
    Name = "${var.name}-db"
  })
}
