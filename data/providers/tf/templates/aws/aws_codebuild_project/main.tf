locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_codebuild_project" "this" {
  artifacts { type = var.artifacts }
  build_timeout = var.build_timeout
  cache {
    type     = var.cache_type
    location = var.cache_location
  }
  description = var.description
  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = var.type
    image_pull_credentials_type = var.image_pull_credentials_type
  }
  # environment_variable {
  #   name="TERRAFORM_VERSION"
  #   value="0.12.16"
  # }
  logs_config {
    cloudwatch_logs {
      group_name  = var.group_name != null ? var.group_name : "${local.name}-app-log-group"
      stream_name = "${local.name}-app-log-stream"
    }
    s3_logs {
      status   = var.s3_logs_enabled
      location = var.s3_logs_location
    }
  }
  name         = var.name
  service_role = var.service_role
  source {
    type                = var.source_type
    location            = var.source_location
    git_clone_depth     = var.git_clone_depth
    report_build_status = var.report_build_status
  }
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, var.tags_default)
}