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
    Environment = "spark"
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

module "security-group-master" {
  source = "terraform-aws-modules/security-group/aws"

  name = "${var.name}-master"
  description = "Security group for EMR master"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    },
    {
      from_port   = 4040
      to_port     = 4040
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    },
    {
      from_port   = 8888
      to_port     = 8888
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    },
    {
      from_port   = 20888
      to_port     = 20888
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Name = "EMR_master"
    Terraform = "true"
    Environment = "spark"
  }
}

module "security-group-slave" {
  source = "terraform-aws-modules/security-group/aws"

  name = "${var.name}-slave"
  description = "Security group for EMR slave"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Name = "emr_slave"
    Terraform = "true"
    Environment = "spark"
  }
}

module "key_pair" {
  source = "./modules/key_pair"
  app_name = var.name  
}