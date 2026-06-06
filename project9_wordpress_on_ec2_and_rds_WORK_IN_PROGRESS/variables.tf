
variable "default_tags" {
  default = {
    TFRepoDirectory = "01_aws_projects/project9/"
  }
  type = map(string)
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
  type    = string
}
# Assign more zones and subnet cidr's as required. 
# Using only one AZ with one public and one private subnet to keep the project simple and cost effective.
variable "availability_zones" {
  default = ["eu-north-1a", "eu-north-1b"]
  type    = list(string)
}
variable "public_subnet_cidr" {
  default = ["10.10.0.0/20", "10.10.16.0/20"]
  type    = list(string)
}
variable "private_subnet_cidr" {
  default = ["10.10.128.0/20", "10.10.144.0/20"]
  type    = list(string)
}
variable "instance_type" {
  default = "t3.micro"
  type    = string
}

variable "policies_to_attach" {
  default = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  type = list(string)
}

variable "key_name" {
  default = "lnkm"
  type    = string
}