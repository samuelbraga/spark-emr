# AWS
variable "aws_region" {}

# VPC
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "private_subnets_cidr" {
  type = list(string)
}
variable "public_subnets_cidr" {
  type = list(string)
}

# EMR
variable "name" {}
variable "name_s3_scripts" {}