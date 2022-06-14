resource "aws_security_group" "rds" {
  name = "rds wordpress"
  description = "security group rds"
  vpc_id = aws_vpc.packer-test.id

  ingress {
    description = "allow rds"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/24" ]
  }

  egress {
    description = "allow all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "rds security group"
  }
}

resource "aws_db_subnet_group" "wordpress" {
  name = "wordpress"
  subnet_ids = [ aws_subnet.packer-sub-two.id, aws_subnet.packer-sub-three.id ]
}

resource "aws_db_instance" "wordpress" {
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  name = "wordpress"
  username = "admin"
  password = "Seletiva#39"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  vpc_security_group_ids = [ aws_security_group.rds.id ]
  db_subnet_group_name = aws_db_subnet_group.wordpress.name
}