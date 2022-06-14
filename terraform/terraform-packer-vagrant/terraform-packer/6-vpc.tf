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

resource "aws_subnet" "packer-sub-two" {
  vpc_id                  = aws_vpc.packer-test.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  tags = {
    "Name" = "packer-sub-two"
  }
}

resource "aws_subnet" "packer-sub-three" {
  vpc_id                  = aws_vpc.packer-test.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.2.0/24"
  tags = {
    "Name" = "packer-sub-three"
  }
}

# IGW
resource "aws_internet_gateway" "packer-igw" {
  vpc_id = aws_vpc.packer-test.id
}

# Route Table
resource "aws_route_table" "packer-route-table-vm" {
  vpc_id = aws_vpc.packer-test.id
  tags = {
    "Name" = "packer-pub"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.packer-igw.id
  }
  depends_on = [
    aws_internet_gateway.packer-igw
  ]
}

resource "aws_route_table" "packer-route-table-db" {
  vpc_id = aws_vpc.packer-test.id
  tags = {
    "Name" = "packer-priv"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.packer-priv.id
  }
  depends_on = [
    aws_nat_gateway.packer-priv
  ]
}

# EIP
resource "aws_eip" "nat-gateway-packer" {
  vpc = true
}

#NAT GATEWAY
resource "aws_nat_gateway" "packer-priv" {
  allocation_id = aws_eip.nat-gateway-packer.id
  subnet_id     = aws_subnet.packer-sub-one.id
  tags = {
    "Name" = "Packer Sub One"
  }
  depends_on = [
    aws_eip.nat-gateway-packer
  ]
}

# Associate Route to Subnet
resource "aws_route_table_association" "packer-route-associate-packer-one" {
  route_table_id = aws_route_table.packer-route-table-vm.id
  subnet_id      = aws_subnet.packer-sub-one.id
}

resource "aws_route_table_association" "production-route-associate-packer-two" {
  route_table_id = aws_route_table.packer-route-table-db.id
  subnet_id      = aws_subnet.packer-sub-two.id
}

resource "aws_route_table_association" "production-route-associate-packer-three" {
  route_table_id = aws_route_table.packer-route-table-db.id
  subnet_id      = aws_subnet.packer-sub-three.id
}