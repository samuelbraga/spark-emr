module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs = data.aws_availability_zones.available.names

  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "spark"
  }
}

module "iam" {
  source   = "./modules/iam"
  app_name = var.name
}

module "security_group_master" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-master"
  description = "Security group for EMR master"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},0.0.0.0/0"
    }
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
    Name        = "EMR_master"
    Terraform   = "true"
    Environment = "spark"
  }
}

module "security_group_slave" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-slave"
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
    Name        = "emr_slave"
    Terraform   = "true"
    Environment = "spark"
  }
}

module "key_pair" {
  source   = "./modules/key_pair"
  app_name = var.name
}

module "emr" {
  source = "./modules/emr"

  name                 = var.name
  subnet_id            = module.vpc.public_subnets[0]
  key_name             = module.key_pair.key_name
  release_label        = var.release_label
  applications         = var.applications
  ebs_root_volume_size = var.ebs_root_volume_size

  master_instance_type  = var.master_instance_type
  master_ebs_size       = var.master_ebs_size
  master_instance_count = var.master_instance_count

  core_instance_type  = var.core_instance_type
  core_instance_count = var.core_instance_count
  core_ebs_size       = var.core_ebs_size

  bid_price_core = var.bid_price_core

  min_instance_core   = var.min_instance_core
  max_instance_core   = var.max_instance_core
  core_threshold_up   = var.core_threshold_up
  core_threshold_down = var.core_threshold_down

  emr_master_security_group     = module.security_group_master.this_security_group_id
  emr_slave_security_group      = module.security_group_slave.this_security_group_id

  emr_ec2_instance_profile = module.iam.emr_ec2_instance_profile
  emr_service_role         = module.iam.emr_service_role
  emr_autoscaling_role     = module.iam.emr_autoscaling_role
}