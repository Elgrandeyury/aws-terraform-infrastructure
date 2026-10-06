locals {
  common_tags = merge(
    {
      Project   = var.name
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${var.name}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.name}-igw"
  })
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.name}-public-${count.index + 1}"
    Tier = "public"
  })
}

resource "aws_subnet" "app" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "${var.name}-app-${count.index + 1}"
    Tier = "application"
  })
}

resource "aws_subnet" "data" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.data_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "${var.name}-data-${count.index + 1}"
    Tier = "data"
  })
}

resource "aws_eip" "nat" {
  count = 2

  domain = "vpc"

  depends_on = [aws_internet_gateway.this]

  tags = merge(local.common_tags, {
    Name = "${var.name}-nat-eip-${count.index + 1}"
  })
}

resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  depends_on = [aws_internet_gateway.this]

  tags = merge(local.common_tags, {
    Name = "${var.name}-nat-${count.index + 1}"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.name}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "app" {
  count = 2

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(local.common_tags, {
    Name = "${var.name}-app-rt-${count.index + 1}"
  })
}

resource "aws_route_table_association" "app" {
  count = 2

  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app[count.index].id
}

resource "aws_route_table" "data" {
  count = 2

  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.name}-data-rt-${count.index + 1}"
  })
}

resource "aws_route_table_association" "data" {
  count = 2

  subnet_id      = aws_subnet.data[count.index].id
  route_table_id = aws_route_table.data[count.index].id
}
