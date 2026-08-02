terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Create a VPC with subnets, internet gateway, NAT gateway and route tables using terraform-aws-modules/vpc/aws module.
module "vpc" {
  source                = "terraform-aws-modules/vpc/aws"
  name                  = "eu-north-1-main-vpc"
  cidr                  = var.vpc_cidr
  enable_dns_hostnames  = true
  enable_dns_support    = true
  azs                   = var.availability_zones
  public_subnets        = var.public_subnet_cidr
  public_subnet_suffix  = "public-subnet"
  private_subnets       = var.private_subnet_cidr
  private_subnet_suffix = "private-subnet"
  enable_nat_gateway    = true
  single_nat_gateway    = false
  tags                  = var.default_tags
}
