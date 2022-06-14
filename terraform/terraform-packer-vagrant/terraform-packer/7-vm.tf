resource "aws_instance" "wordpress" {
  ami                    = data.aws_ami.wordpress
  instance_type          = var.instance_type
  key_name               = "ec2-instance"
  vpc_security_group_ids = [aws_security_group.packer-instance.id]
  subnet_id              = aws_subnet.packer-sub-one.id
  #user_data              = file("wordpress.sh")

  tags = {
    "Name" = "Wordpress"
  }

  depends_on = [
    aws_key_pair.ec2-key-pair,
    aws_db_instance.wordpress
  ]
}