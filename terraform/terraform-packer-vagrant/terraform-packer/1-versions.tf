terraform {
#  required_version = "~> 0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  access_key = "id-key"
  secret_key = "secret-key"
}