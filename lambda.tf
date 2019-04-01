resource "aws_lambda_function" "test_lambda" {
  s3_bucket = "${aws_s3_bucket.files.bucket}"
  s3_key = "lambda-dummy.zip"
  // only used for lambda creation, actual lambda will be deployed by codebuild
  function_name = "${var.basename}-lambda"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "com.not.Needed"
  runtime = "provided"
  timeout = "120"
  memory_size = "256"
  tags {
    type = "${var.basename}"
  }
}
