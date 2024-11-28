resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = var.tag_name_vpc
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    name = var.tag_name_subnets
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    name = var.tag_name_priv_subnets
  }
}
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.tag_name_ig
  }
}

resource "aws_eip" "nat" {
  tags = {
    Name = "nat-gateway-test"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "nat-gateway"
  }
}

