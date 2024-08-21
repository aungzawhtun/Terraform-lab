terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.62.0"
    }
  }
}

provider "aws" {
    profile = "terraform-lab"
    region = "ap-southeast-1"
 
    //access key -> ~/.aws/crendentials (terraform-lab)
    //secret key
}
