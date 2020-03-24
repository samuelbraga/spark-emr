# VPC
output "vpc_id" {
  description = "vpc id"
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "vpc cidr block"
  value = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "private subnets"
  value = module.vpc.private_subnets
}

output "public_subnets" {
  description = "public subnets"
  value = module.vpc.public_subnets
}

# S3 scripts
output "s3_scripts_id" {
  description = "id s3 scripts"
  value = module.s3_scripts.s3_id
}

# IAM
output "emr_service_role" {
  description = "service role EMR"
  value = module.iam.emr_service_role
}

output "emr_autoscaling_role" {
  description = "autoscaling role EMR"
  value = module.iam.emr_autoscaling_role
}

output "emr_ec2_instance_profile" {
  description = "ec2 role EMR"
  value = module.iam.emr_ec2_instance_profile
}