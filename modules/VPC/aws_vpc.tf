
# VPC Resource
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tag
  }
}


# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.IGW_tag
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  for_each = var.az_public_subnet

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "public_subnet-${each.key}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  for_each = var.az_private_subnet

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "private_subnet-${each.key}"
  }
}

# Database Subnet
resource "aws_subnet" "database_subnet" {
  for_each = var.az_database_subnet

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "database_subnet-${each.key}"
  }
}


# Route Table 
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.RT_tag
  }
}

# Public subnet route table association
resource "aws_route_table_association" "public_subnet_route_table_association" {
  for_each = var.az_public_subnet

  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}
// Outputs

output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id" {
  value = toset([for subnet in aws_subnet.public_subnet : subnet.id])
}
output "private_subnet_id" {
  value = toset([for subnet in aws_subnet.private_subnet : subnet.id])
}
output "db_subnet_id" {
  value = toset([for subnet in aws_subnet.database_subnet : subnet.id])
}