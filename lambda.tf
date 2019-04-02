resource "aws_lambda_function" "test_lambda" {
  function_name = "${var.basename}-lambda"
  filename = "graal-lambda.zip"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "com.not.Needed"
  runtime = "provided"
  timeout = "120"
  memory_size = "256"
  tags {
    type = "${var.basename}"
  }
}
output "function_name" {
  value = "${aws_lambda_function.test_lambda.function_name}"
}