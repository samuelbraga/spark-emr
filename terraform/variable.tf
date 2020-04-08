# AWS
variable "aws_region" {}

# VPC
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "public_subnets_cidr" {
  type = list(string)
}

# EMR
variable "name" {}
variable "release_label" {}
variable "applications" {
  type = list(string)
}
variable "ebs_root_volume_size" {}

# Master node configurations
variable "master_instance_type" {}
variable "master_ebs_size" {}
variable "master_instance_count" {}

# Slave nodes configurations
variable "core_instance_type" {}
variable "core_instance_count" {}
variable "core_ebs_size" {}

variable "bid_price_core" {}
variable "min_instance_core" {}
variable "max_instance_core" {}
variable "core_threshold_up" {}
variable "core_threshold_down" {}