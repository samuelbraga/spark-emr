# AWS
aws_region = "us-west-2"

# VPC
vpc_name = "spark"
vpc_cidr_block = "10.1.0.0/16"
private_subnets_cidr = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
public_subnets_cidr = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

# EMR
name = "spark-samuelbraga"
name_s3_scripts = "spark-scripts-samuelbraga"