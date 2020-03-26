# ERM config
variable "name" {}
variable "name_s3_scripts" {}
variable "subnet_id" {}
variable "key_name" {}
variable "release_label" {}
variable "applications" {
  type = list(string)
}
variable "ebs_root_volume_size" {}

# Master Node Configuration
variable "master_instance_type" {}
variable "master_ebs_size" {}
variable "master_instance_count" {}

# Slave Node Configuration
variable "core_instance_type" {}
variable "core_instance_count" {}
variable "core_ebs_size" {}
variable "bid_price_core" {}

variable "min_instance_core" {}
variable "max_instance_core" {}
variable "core_threshold_up" {}
variable "core_threshold_down" {}

# Security group
variable "emr_master_security_group" {}
variable "emr_slave_security_group" {}

# IAM config
variable "emr_ec2_instance_profile" {}
variable "emr_service_role" {}
variable "emr_autoscaling_role" {}