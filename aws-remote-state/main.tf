terraform {
  required_version = ">= v1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "felipe.funck"
      managed-by = "terraform"
    }
  }
}
