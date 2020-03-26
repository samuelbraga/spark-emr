output "id" {
  value = "${aws_emr_cluster.emr_spark_cluster.id}"
}

output "name" {
  value = "${aws_emr_cluster.emr_spark_cluster.name}"
}

output "master_public_dns" {
  value = "${aws_emr_cluster.emr_spark_cluster.master_public_dns}"
}