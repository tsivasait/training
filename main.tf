#create a VPC
resource "AWS_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "dev-vpc"
  } 
}
#create a subnet D1
resource "aws_subnet" "D1" {
  vpc_id = aws_vpc.dev.id
  cidr_block = "10.0.0.0/18"
  availability_zone = "us-east-1a"  
}
#create a subnet D2
resource "aws_subnet" "D2" {
  vpc_id = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}
#create a IG
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.dev.id
  tags = {
    name = "dev-IG"
  }
}
#create a route table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    name = "dev-RT"
  }
} 
#create a route table association
resource "aws_route_table_association" "RTA" {
  subnet_id = aws_subnet.D1.id
  route_table_id = aws_route_table.RT.id
}
