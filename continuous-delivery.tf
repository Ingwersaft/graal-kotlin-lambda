variable "github-user" {
  default = "Ingwersaft"
}
variable "github-repo" {
  default = "graal-kotlin-lambda"
}
variable "slack-webhook" {
  default = "https://hooks.slack.com/services/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"
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
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/java:openjdk-8"
    type = "LINUX_CONTAINER"

    environment_variable {
      "name" = "S3_BUCKET"
      "value" = "s3://${aws_s3_bucket.files.bucket}"
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
