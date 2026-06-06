# Using terraform modules to create ec2 instance and security group in eu-north-1 region.

resource "aws_instance" "eu_north_1_ec2" {
  provider               = aws.eu-north-1
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = ["${module.eu_north_1_security_group.security_group_id}"]
  subnet_id              = module.vpc.public_subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.ec2_demo_instance_profile.name

  tags = merge(
    var.default_tags,
    {
      Name = "eu-north-1-ec2"
    }
  )
}

module "eu_north_1_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
  providers = {
    aws = aws.eu-north-1
  }
  name               = "eu-north-1-security-group"
  description        = "test security group"
  vpc_id             = module.vpc.vpc_id
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "10.103.0.0/16"
    },
    {
      rule        = "all-all"
      cidr_blocks = "10.106.0.0/16"
    },
  ]
}