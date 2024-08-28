//Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

variable "base_vpc" {
  type = object({
    Name = string
    cidr = string
  })
  default = {
    Name = "VPC-A"
    cidr = "10.0.0.0/16"
  }
}

resource "aws_vpc" "base_vpc" {
  cidr_block = var.base_vpc.cidr //10.0.0.0/16
  tags = {
    Name = var.base_vpc.Name //VPC-A
  }
}


resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = aws_vpc.base_vpc.id
  tags = {
    Name = "" //VPC-A-IGW
  }
}

# variable "Love_letter" {
#   type = map(string)
#   default = {
#     "myanmar" = "chit tal"
#     "Englisk" = "I Love You"
#     "chinese" = "Wai ai ni"
#   }
# }
# resource "local_file" "Love_letter" {
#   filename ="./yesarsar.txt"
#   content = var.Love_letter["chinese"] 
# }

# output "love_content" {
#   value = local_file.Love_letter.content
# }

variable "public_subnets" {
  type = map(object({
    cidr = string
    zone = string
    Name = string
  }))

  default = {
    "public_subnet1" = {
      cidr = "10.0.1.0/24"
      zone = "ap-southeast-1a"
      Name = "Public-Subnet-1"
    },

    "public_subnet2" = {
      cidr = "10.0.2.0/24"
      zone = "ap-southeast-1b"
      Name = "Public-Subnet-2"
    },

    "public_subnet3" = {
      cidr = "10.0.3.0/24"
      zone = "ap-southeast-1c"
      Name = "Public-Subnet-3"
    }
  }
}


locals {
  vpc_name = aws_vpc.base_vpc.tags.Name
}


resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets  //map (object) -> 3
  vpc_id                  = aws_vpc.base_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.zone //ap-southeast-1a 
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.vpc_name}- ${each.value.Name}" //VPC-A-Public-Subnet-1
  }
}
# resource "aws_subnet" "public_subnets" {
#   count                   = length(var.public_subnets)
#   vpc_id                  = aws_vpc.base_vpc.id
#   cidr_block              = var.public_subnets[count.index].cidr
#   availability_zone       = var.public_subnets[count.index].zone //ap-southeast-1a 
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${local.vpc_name}-${var.public_subnets[count.index].Name}" //VPC-A-Public-Subnet-1
#   }
# }