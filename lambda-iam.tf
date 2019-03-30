resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.basename}-iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_policy" "lambdapolicy" {
  name = "${var.basename}-lambda-policy"
  description = "${var.basename} lambda policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:StartInstances",
        "ec2:StopInstances"],
      "Resource": ["*"]
    },
{
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
  ]
}
EOF
}
resource "aws_iam_policy_attachment" "lambda-attach" {
  name = "${var.basename}-lambda-attachment"
  roles = [
    "${aws_iam_role.iam_for_lambda.name}"]
  policy_arn = "${aws_iam_policy.lambdapolicy.arn}"
}