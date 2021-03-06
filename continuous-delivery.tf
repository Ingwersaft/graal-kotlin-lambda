variable "github-user" {
  default = "Ingwersaft"
}
variable "github-repo" {
  default = "graal-kotlin-lambda"
}
variable "slack-webhook" {
  default = "${var.slackhook}"
}

resource "aws_codebuild_project" "build" {
  name = "${var.basename}-codebuild-project"
  description = "automatic codebuild project for ${var.basename} managed by terraform"
  build_timeout = "10"
  service_role = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "S3"
    location = "${aws_s3_bucket.files.bucket}"
  }

  environment {
    compute_type = "BUILD_GENERAL1_MEDIUM"
    image = "aws/codebuild/java:openjdk-8"
    type = "LINUX_CONTAINER"

    environment_variable {
      "name" = "S3_BUCKET"
      "value" = "${aws_s3_bucket.files.bucket}"
    }
    environment_variable {
      "name" = "S3_BUCKET_URL"
      "value" = "s3://${aws_s3_bucket.files.bucket}"
    }
    environment_variable {
      "name" = "S3_KEY"
      "value" = "graal-lambda.zip"
    }
    environment_variable {
      "name" = "FUNCTION_NAME"
      "value" = "${aws_lambda_function.test_lambda.function_name}"
    }
    environment_variable {
      "name" = "SLACK_WEBHOOK"
      "value" = "${var.slack-webhook}"
    }
  }

  source {
    type = "GITHUB"
    location = "https://github.com/${var.github-user}/${var.github-repo}"
    git_clone_depth = 1
    auth {
      type = "OAUTH"
    }
  }
  tags {
    "type" = "${var.basename}"
  }
}
resource "aws_codebuild_webhook" "github-hook" {
  project_name = "${aws_codebuild_project.build.name}"
}
