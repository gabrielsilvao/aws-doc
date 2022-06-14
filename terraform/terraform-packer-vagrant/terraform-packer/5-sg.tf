resource "aws_security_group" "packer-instance" {
  name        = "packer-instance"
  description = "packer security group"
  vpc_id      = aws_vpc.packer-test.id

  ingress {
    description = "allow ssh"
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

  tags = {
    "Name" = "allow ssh"
  }
}