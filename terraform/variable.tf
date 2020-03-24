variable "aws_region" {
  description = "AWS region where we'll create the resources"
  type = string
  default = "us-west-2"
}

variable "vpc_name" {
  description = "VPC name"
  type = string
  default = "vpc-emr-1"
}

variable "vpc_cidr_block" {
  description = " VPC cidr block"
  type = string
  default = "10.1.0.0/16"
}

variable "private_subnets_cidr" {
  description = "Private subnet cidr blocks"
  type = list(string)
  default = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]
}

variable "public_subnets_cidr" {
  description = "Public subnet cidr blocks"
  type = list(string)
  default = [
    "10.1.101.0/24",
    "10.1.102.0/24",
    "10.1.103.0/24"
  ]
}