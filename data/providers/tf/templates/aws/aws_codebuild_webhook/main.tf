locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_codebuild_project" "this" {
  artifacts { type = var.artifacts }
  build_timeout = var.build_timeout
  environment {
    compute_type = var.compute_type
    image        = var.image
    type         = var.type
  }
  logs_config {
    cloudwatch_logs {
      group_name  = var.group_name != null ? var.group.name : "${local.name}-log-group"
      stream_name = local.name
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
  tags = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}