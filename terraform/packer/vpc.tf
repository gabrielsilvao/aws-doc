# VPC
resource "aws_vpc" "packer-test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "packer-test"
  }
}

# Subnet
resource "aws_subnet" "packer-sub-one" {
  vpc_id                  = aws_vpc.packer-test.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "packer-sub-one"
  }
}

# IGW
resource "aws_internet_gateway" "packer-igw" {
  vpc_id = aws_vpc.packer-test.id
}

# Route Table
resource "aws_route_table" "packer-route-table" {
  vpc_id = aws_vpc.packer-test.id
  tags = {
    "Name" = "packer-test"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.packer-igw.id
  }
}

# Associate Route to Subnet
resource "aws_route_table_association" "packer-route-associate" {
  route_table_id = aws_route_table.packer-route-table.id
  subnet_id      = aws_subnet.packer-sub.one.id
}