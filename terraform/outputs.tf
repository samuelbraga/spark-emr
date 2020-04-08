# VPC
output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "vpc cidr block"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "public subnets"
  value       = module.vpc.public_subnets
}

# IAM
output "emr_service_role" {
  description = "service role EMR"
  value       = module.iam.emr_service_role
}

output "emr_autoscaling_role" {
  description = "autoscaling role EMR"
  value       = module.iam.emr_autoscaling_role
}

output "emr_ec2_instance_profile" {
  description = "ec2 role EMR"
  value       = module.iam.emr_ec2_instance_profile
}

# SECURITY
output "master_security_group_id" {
  description = "master security group id"
  value       = module.security_group_master.this_security_group_id
}

output "slave_security_group_id" {
  description = "slave security group id"
  value       = module.security_group_slave.this_security_group_id
}

# KEY
output "key_name" {
  description = "key pais name"
  value       = module.key_pair.key_name
}

# EMR
output "emr_id" {
  description = "emr id"
  value       = module.emr.id
}

output "emr_name" {
  description = "emr id"
  value       = module.emr.name
}

output "emr_master_public_dns" {
  description = "emr master public dns"
  value       = module.emr.master_public_dns
}