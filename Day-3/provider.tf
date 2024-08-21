 terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
   profile = "terraform-lab"
    region = "ap-southeast-1"
  # Configuration options
}