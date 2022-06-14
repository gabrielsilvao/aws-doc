data "aws_caller_identity" "current" {}

data "aws_ami" "wordpress" {
  most_recent = true

  filter {
    name = "Name"
    values = ["learn-packer"]
  }

  owners = [data.aws_caller_identity.current.account_id]
}