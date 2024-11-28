resource "aws_route_table" "ig_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
  tags = {
    Name = var.tag_name_rt_public
  }
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = var.tag_name_rt_private
  }
}
resource "aws_route_table_association" "pub_subnet_association-1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.ig_rt.id
}

resource "aws_route_table_association" "priv_subnet_association-2" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.priv_rt.id
}