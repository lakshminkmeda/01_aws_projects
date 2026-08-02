terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">4.16"
    }
  }
}

# Create vpc, a public subnet and a private subnet
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-north-1a"
  tags = {
    Name = "public_subnet"
  }
  map_public_ip_on_launch = true
}
resource "aws_subnet" "private_01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-north-1a"
  tags = {
    Name = "private_subnet_01"
  }
  map_public_ip_on_launch = false
}
resource "aws_subnet" "private_02" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-north-1b"
  tags = {
    Name = "private_subnet_02"
  }
  map_public_ip_on_launch = false
}
# Create Internet gateway, route tables for public subnets
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my-ig"
  }
}
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "routetable_public_internetgateway"
  }
}
resource "aws_route_table_association" "rt_assoc_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "routetable_private"
  }
}
resource "aws_route_table_association" "rt_assoc_private_01" {
  subnet_id      = aws_subnet.private_01.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt_assoc_private_02" {
  subnet_id      = aws_subnet.private_02.id
  route_table_id = aws_route_table.rt_private.id
}

# Security group for vpc
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for allowing traffic from VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["195.140.213.216/32"]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for allowing traffic to RDS from VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
  tags = {
    Name = "rds-sg"
  }
}