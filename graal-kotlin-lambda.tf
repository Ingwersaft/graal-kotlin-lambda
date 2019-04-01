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

output "bucket" {
  value = "s3://${aws_s3_bucket.files.bucket}"
}
resource "aws_s3_bucket" "files" {
  bucket = "${var.basename}"
  acl = "private"
  force_destroy = true
  tags {
    type = "${var.type}"
  }
}
