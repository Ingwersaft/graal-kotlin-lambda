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
