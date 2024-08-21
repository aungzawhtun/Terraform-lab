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
resource "aws_subnet" "mysubnet" {
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = "ap-southeast-1a"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "my-subnet"
  }
}

resource "aws_subnet" "my-subnet1" {
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = "ap-southeast-1b"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "my-subnet1"
  }
}
resource "aws_subnet" "my-subnet2" {
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = "ap-southeast-1c"
  cidr_block = "10.0.2.0/24"
  tags = {
     Name = "my-subnet2"
  }
}