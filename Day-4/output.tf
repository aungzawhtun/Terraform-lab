output "my_zones" {
  value = data.aws_availability_zones.available.names
}
output "name" {
  value = "My VPC id is ${aws_vpc.base_vpc.id}." // call to interpolation
} 