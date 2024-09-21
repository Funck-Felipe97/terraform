terraform {
  required_version = ">= v1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }

  backend "s3" {
    bucket = "fcfunck-remote-state"
    key    = "aws-vm/terraform.tfstate"
    region = "us-east-1"
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

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "fcfunck-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

