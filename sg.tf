resource "random_id" "sg_id" {
  byte_length = 4
}

resource "random_id" "priv_sg_id" {
  byte_length = 4
}
resource "aws_security_group" "my_sg" {
  name        = "SG"
  description = "Security group"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = var.tag_name_sg
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_priv_sg" {
  name        = "SG"
  description = "Security group"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = var.tag_name_priv_sg
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

