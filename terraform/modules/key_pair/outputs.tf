output "key_name" {
  description = "key name for connection ssh"
  value = aws_key_pair.key_tf.key_name
}