resource "aws_instance" "appprod" {
    ami = "ami-060e277c0d4cce553"  //ubuntu ami (ap-southeast-1 -> ami-xxxxxxx) , (ap-southeast-1 -> ami-yyyyyy)
    instance_type = "t2.micro" //1 cpu, 1 GB RAM
    tags = {
      Name = "Welcome to Yangon"
    }
   
}