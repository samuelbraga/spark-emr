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