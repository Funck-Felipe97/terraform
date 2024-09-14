terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "5.63.0"
      configuration_aliases = [aws.provider_1, aws.provider_2]
    }
  }
}
