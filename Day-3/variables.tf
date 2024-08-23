variable "my_vpc_name" {
    default = "Hello My Baby"
}

variable "my_vpc_cidr" {
    default = "10.0.0.0/16"  
}

#                     0      ,        1          ,       2
# zone->             1a      ,       1b          ,       1c
# cidr->        10.0.0.0/24  ,   10.0.1.0/24     ,   10.0.2.0/24                
# subnetname->  mysubnet     ,    mysubnet1      ,   mysubnet2

variable "zone_for_subnets" {
    type = list(string)
    default = [ "ap-southeast-1a",  "ap-southeast-1b",  "ap-southeast-1c" ]
}

variable "cidr_for_subnets" {
    type = list(string)
    default = [ "10.0.0.0/24",   "10.0.1.0/24",   "10.0.2.0/24" ]
}
variable "name_for_subnets" {
    type = list(string)
    default = [ "mysubnet" , "mysubnet1", "mysubnet2" ]
}