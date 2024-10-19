terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "s3-bucket"
    Environment = "dev"
  }
}