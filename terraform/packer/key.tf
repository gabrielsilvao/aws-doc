resource "tls_private_key" "public_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name = "ec2-instance"
  public_key = tls_private_key.public_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.ec2-key-pair.key_name}.pem"
  content = tls_private_key.public_key.private_key_pem
}