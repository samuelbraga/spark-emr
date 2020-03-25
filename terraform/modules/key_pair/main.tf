resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_file" "key_priv" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/id_rsa"
}

resource "null_resource" "key_chown" {
  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/id_rsa"
  }

  depends_on = [local_file.key_priv]
}

resource "null_resource" "key_gen" {
  provisioner "local-exec" {
    command = "rm -f ${path.module}/id_rsa.pub && ssh-keygen -y -f ${path.module}/id_rsa > ${path.module}/id_rsa.pub"
  }

  depends_on = [local_file.key_priv]
}

data "local_file" "key_pub" {
  filename = "${path.module}/id_rsa.pub"

  depends_on = [null_resource.key_gen]
}

resource "aws_key_pair" "key_tf" {
  key_name   = "${var.app_name}-key"
  public_key = data.local_file.key_pub.content
}