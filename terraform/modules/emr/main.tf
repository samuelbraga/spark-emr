resource "aws_emr_cluster" "emr_spark_cluster" {
  name  = var.name
  release_label = var.release_label
  applications = var.applications
  termination_protection = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    subnet_id  = var.subnet_id
    key_name = var.key_name
    emr_managed_master_security_group = var.emr_master_security_group
    emr_managed_slave_security_group = var.emr_slave_security_group
    instance_profile = var.emr_ec2_instance_profile
  }

  ebs_root_volume_size = var.ebs_root_volume_size

  master_instance_group {
    name = "${var.name} EMR master"
    instance_type = var.master_instance_type
    instance_count = var.master_instance_count

    ebs_config {
      size = var.master_ebs_size
      type = "gp2"
      volumes_per_instance = 1
    }
  }

  core_instance_group {
    name           = "${var.name} EMR slave"

    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count

    ebs_config {
      size                 = var.core_ebs_size
      type                 = "gp2"
      volumes_per_instance = 1
    }

    bid_price = var.bid_price_core

    autoscaling_policy = <<EOF
{
  "Constraints": {
    "MinCapacity": ${var.min_instance_core},
    "MaxCapacity": ${var.max_instance_core}
  },
  "Rules": [
    {
      "Name": "ScaleOutMemoryPercentage",
      "Description": "Scale out if YARNMemoryAvailablePercentage is less than ${var.core_threshold_up}",
      "Action": {
        "SimpleScalingPolicyConfiguration": {
          "AdjustmentType": "CHANGE_IN_CAPACITY",
          "ScalingAdjustment": 1,
          "CoolDown": 300
        }
      },
      "Trigger": {
        "CloudWatchAlarmDefinition": {
          "ComparisonOperator": "LESS_THAN",
          "EvaluationPeriods": 1,
          "MetricName": "YARNMemoryAvailablePercentage",
          "Namespace": "AWS/ElasticMapReduce",
          "Period": 300,
          "Statistic": "AVERAGE",
          "Threshold": ${var.core_threshold_up},
          "Unit": "PERCENT"
        }
      }
    },
    {
      "Name": "ReduceOutMemoryPercentage",
      "Description": "Scale out if YARNMemoryAvailablePercentage is more than ${var.core_threshold_down}",
      "Action": {
        "SimpleScalingPolicyConfiguration": {
          "AdjustmentType": "CHANGE_IN_CAPACITY",
          "ScalingAdjustment": -1,
          "CoolDown": 300
        }
      },
      "Trigger": {
        "CloudWatchAlarmDefinition": {
          "ComparisonOperator": "GREATER_THAN",
          "EvaluationPeriods": 1,
          "MetricName": "YARNMemoryAvailablePercentage",
          "Namespace": "AWS/ElasticMapReduce",
          "Period": 300,
          "Statistic": "AVERAGE",
          "Threshold": ${var.core_threshold_down},
          "Unit": "PERCENT"
        }
      }
    }
  ]
}
EOF
}

  service_role = var.emr_service_role
  autoscaling_role = var.emr_autoscaling_role

  configurations_json = <<EOF
    [
    {
    "Classification": "spark-defaults",
      "Properties": {
      "maximizeResourceAllocation": "true",
      "spark.dynamicAllocation.enabled": "true"
      }
    }
  ]
  EOF

  tags = {
    Name = "${var.name} - Spark cluster"
  }
}
