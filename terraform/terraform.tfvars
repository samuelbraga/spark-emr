# AWS
aws_region = "us-east-1"

# VPC
vpc_name             = "spark"
vpc_cidr_block       = "10.69.0.0/16"
public_subnets_cidr  = ["10.69.101.0/24"]

# EMR
name                 = "spark-samuelbraga"
release_label        = "emr-6.0.0"
applications         = ["Hadoop", "Spark"]
ebs_root_volume_size = "12"

# Master node configurations
master_instance_type  = "m4.xlarge"
master_ebs_size       = "50"
master_instance_count = 1

# Slave nodes configurations
core_instance_type  = "m4.xlarge"
core_instance_count = 1
core_ebs_size       = "50"

bid_price_core = 0.5

min_instance_core   = 1
max_instance_core   = 1
core_threshold_up   = 20
core_threshold_down = 80