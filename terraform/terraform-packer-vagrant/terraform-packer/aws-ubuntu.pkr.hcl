packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "wordpress" {
  ami_name      = "wordpress"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  name    = "wordpress"
  sources = [
    "source.amazon-ebs.wordpress"
  ]

  provisioner "shell" {
      environment_vars = [
          "FOO=hello world",
      ]
      scripts = [
        "files/init.sh"
      ]
  }

  provisioner "shell" {
      inline = ["echo This provisioner runs last"]
  }

}