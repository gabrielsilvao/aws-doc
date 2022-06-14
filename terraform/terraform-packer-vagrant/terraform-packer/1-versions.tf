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
  access_key = "AKIAUIABRPA2NG5WD75U"
  secret_key = "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"
}