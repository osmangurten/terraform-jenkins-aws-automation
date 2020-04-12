provider "aws" {
  region = "us-east-1"
}

# Vpc

module "vpc" {
  source                       = "../modules/aws-vpc"
  vpc-location                 = "N.Virginia"
  namespace                    = "cloudtest"
  name                         = "vpc"
  stage                        = "DEV"
  map_public_ip_on_launch      = "true"
  total-nat-gateway-required   = "1"
  create_database_subnet_group = "false"
  vpc_cidr                     = "10.11.0.0/16"
  vpc-public-subnet-cidr       = ["10.11.1.0/24", "10.11.2.0/24"]
  vpc-private-subnet-cidr      = ["10.11.4.0/24", "10.11.5.0/24"]
  vpc-database_subnets-cidr    = ["10.11.7.0/24", "10.11.8.0/24"]

}

#EC2
#
# module "ec2" {
#   source                      = "../../modules/aws-ec2"
#   namespace                   = "cloudtest"
#   stage                       = "dev"
#   name                        = "ec2"
#   key_name                    = "ec2-v12"
#   public_key                  = file("../../modules/secrets/ec2-v12.pub")
#   instance_count              = 1
#   ami                         = "ami-00aa4671cbf840d82"
#   instance_type               = "t3a.micro"
#   associate_public_ip_address = "true"
#   subnet_ids                  = module.vpc.public-subnet-ids
#   vpc_security_group_ids      = [module.sg2.aws_security_group_default, module.sg1.aws_security_group_default]
#   iam_instance_profile        = module.instance-profile.instance-profile-name
# }
