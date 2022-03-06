# VPC
resource "aws_vpc" "production" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "production"
  }
}

# Subnet
resource "aws_subnet" "production-pub" {
  vpc_id                  = aws_vpc.production.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "production-pub"
  }
}

resource "aws_subnet" "production-priv1" {
  vpc_id            = aws_vpc.production.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    "Name" = "production-priv1"
  }
}

resource "aws_subnet" "production-priv2" {
  vpc_id            = aws_vpc.production.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    "Name" = "production-priv2"
  }
}

# IGW
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production.id
}

# Route Table
resource "aws_route_table" "production-route-table" {
  vpc_id = aws_vpc.production.id
  tags = {
    "Name" = "production"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production-igw.id
  }
}

# EIP
resource "aws_eip" "nat-gateway-priv1" {
  vpc = true
}

resource "aws_eip" "nat-gateway-priv2" {
  vpc = true
}

# NAT Gateway

resource "aws_nat_gateway" "production-priv1" {
  allocation_id = aws_eip.nat-gateway-priv1.id
  subnet_id     = aws_subnet.production-priv1.id
  tags = {
    "Name" = "Production Priv 1"
  }
}

resource "aws_nat_gateway" "production-priv2" {
  allocation_id = aws_eip.nat-gateway-priv2.id
  subnet_id     = aws_subnet.production-priv2.id
  tags = {
    "Name" = "Production Priv 2"
  }
}

# Associate Route to Subnet
resource "aws_route_table_association" "production-route-associate" {
  route_table_id = aws_route_table.production-route-table.id
  subnet_id      = aws_subnet.production-pub.id
}

resource "aws_route_table_association" "production-route-associate-priv1" {
  route_table_id = aws_route_table.production-route-table.id
  subnet_id      = aws_subnet.production-priv1.id
}

resource "aws_route_table_association" "production-route-associate-priv2" {
  route_table_id = aws_route_table.production-route-table.id
  subnet_id      = aws_subnet.production-priv2.id
}