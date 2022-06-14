resource "aws_instance" "packer-instance" {
    ami = "${var.AMI_ID}"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.packer-sub-one.id
    vpc_security_group_ids = [aws_security_group.packer-instance.id]
    key_name = "aws_key_pair.ec2-key-pair"
}