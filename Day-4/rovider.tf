provider "aws" {
  profile = "terraform-lab"
  default_tags {
    tags = {
      "Managed_by" = "Terraform"
    }
  }
}

