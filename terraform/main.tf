module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs = data.aws_availability_zones.available.names

  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "emr"
  }
}

module "s3_scripts" {
  source = "./modules/s3_scripts"
  name = var.name_s3_scripts
}

module "iam" {
  source = "./modules/iam"
  app_name = var.name
}