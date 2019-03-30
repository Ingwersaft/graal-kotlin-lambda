provider "aws" {
  region = "eu-central-1"
}
terraform {
  backend "s3" {
    bucket = "terraform-state-kesselring"
    key = "graal-kotlin-lambda"
    region = "eu-central-1"
  }
}
variable "type" {
  default = "graal-kotlin-lambda"
}
variable "basename" {
  default = "graal-kotlin-lambda"
}

output "ssh" {
  value = "ssh ec2-user@${aws_instance.build-instance.public_ip}"
}
output "bucket" {
  value = "s3://${aws_s3_bucket.files.bucket}"
}
output "aws-s3-sync-command" {
  value = "aws s3 sync build/dist/ s3://${aws_s3_bucket.files.bucket}"
}
resource "aws_s3_bucket" "files" {
  bucket = "${var.basename}"
  acl = "private"
  tags {
    type = "${var.type}"
  }
}
resource "aws_key_pair" "ec2key" {
  key_name = "mauer-key-${var.basename}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
resource "aws_security_group" "hc-sec-group" {
  name = "${var.basename}-sec-group"
  description = "${var.basename} VPC security group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    type = "${var.type}"
  }
}

