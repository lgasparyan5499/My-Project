data "aws_ami" "amazon" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
}

resource "aws_instance" "EC2-1" {
  ami              = data.aws_ami.amazon.id
  instance_type    = var.instance-type
  subnet_id        = aws_subnet.public_subnet.id
  user_data_base64 = base64encode(file("init1.sh"))
  tags = {
    name = "${var.tag_name}1"
  }
}
resource "aws_instance" "EC2-2" {
  ami              = data.aws_ami.amazon.id
  instance_type    = var.instance-type
  subnet_id        = aws_subnet.private_subnet.id
  user_data_base64 = base64encode(file("init1.sh"))
  tags = {
    name = "${var.tag_name}2"
  }
}
