locals {
  #name=replace((length(local.name) > 64 ? substr(local.name, 0,63) : local.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_codepipeline" "this" {
  artifact_store {
    location = var.artifact_store_bucket
    type     = var.artifact_store_type
  }
  name = local.name
  stage {
    name = "Source"
    action {
      name             = "Source-${var.git_repository_name}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = var.git_repository_name
        BranchName     = each.value
      }
    }
  }
  stage {
    name = "Build"
    action {
      name             = "Build-${aws_codebuild_project.codebuild_deployment["build"].name}"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.codebuild_deployment["build"].name
        EnvironmentVariables = jsonencode([{
          name  = "ENVIRONMENT"
          value = each.value
          },
          {
            name  = "PROJECT_NAME"
            value = var.account_type
        }])
      }
    }
  }
  /* Uncomment if you wish to have a confirmation step
  stage {
    name = "Confirm"
    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }  
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["source_output"]
      version         = "1"
      configuration = {
        BucketName = aws_s3_bucket.website.bucket
        Extract    = "true"
      }
    }
  }
  */
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, var.tags_default)
}