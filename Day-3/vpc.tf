//Declare the data source
data "aws_availability_zones" "available" {
    state = "available"
    filter {
      name = "zone-type"
      values = ["availability-zone"]
    }
}

resource "aws_vpc" "my-vpc" {
    cidr_block = var.my_vpc_cidr
    tags = {
      Name = var.my_vpc_name
    }
}

resource "aws_internet_gateway" "myigw" {
    tags = {
      Name = "myigw"
    }
}

resource "aws_internet_gateway_attachment" "igw_pub" {
  internet_gateway_id = aws_internet_gateway.myigw.id
  vpc_id              = aws_vpc.my-vpc.id 
}

resource "aws_route_table" "my_public_rtb" {
    vpc_id = aws_vpc.my-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
    tags = {
      Name = "My Public Route Table"
    }
}

//Subnet
// Count

resource "aws_subnet" "mysubnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = var.zone_for_subnets[count.index]
  cidr_block = var.cidr_for_subnets[count.index]
  tags = {
    Name = var.name_for_subnets[count.index]
  }
}

//route table associate
resource "aws_route_table_association" "my_public_rtb" {
    count = length(aws_subnet.mysubnet)
    route_table_id = aws_route_table.my_public_rtb.id
    subnet_id = aws_subnet.mysubnet[count.index].id
}

# resource "aws_route_table_association" "pub_rtb_subnets  " {
#   route_table_id = aws_route_table.my_public_rtb.id
#   subnet_id = aws_subnet.mysubnet.[0]
  
# # }
# # resource "aws_route_table_association" "pub_rtb_subnets  " {
# #   route_table_id = aws_route_table.my_public_rtb.id
# #   subnet_id = aws_subnet.mysubnet.[1]
  
# # }
# # resource "aws_route_table_association" "pub_rtb_subnets  " {
# #   route_table_id = aws_route_table.my_public_rtb.id
# #   subnet_id = aws_subnet.mysubnet.[2]
  
# # }

# resource "aws_subnet" "mysubnet1" {
#   vpc_id = aws_vpc.my-vpc.id
#   availability_zone = "ap-southeast-1b"
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "my-subnet1"
#   }
# }
# resource "aws_subnet" "mysubnet2" {
#   vpc_id = aws_vpc.my-vpc.id
#   availability_zone = "ap-southeast-1c"
#   cidr_block = "10.0.2.0/24"
#   tags = {
#      Name = "my-subnet2"
#   }
# }