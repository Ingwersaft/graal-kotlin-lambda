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
resource "aws_instance" "build-instance" {
  depends_on = [
    "aws_key_pair.ec2key",
  ]
  ami = "ami-7c4f7097"
  instance_type = "t3.medium"
  key_name = "${aws_key_pair.ec2key.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.hc-sec-group.id}"]

  user_data = "${file("init_instance.sh")}"

  iam_instance_profile = "${aws_iam_instance_profile.profile.name}"

  instance_initiated_shutdown_behavior = ""

  tags {
    type = "${var.type}"
  }
}
