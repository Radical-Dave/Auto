# data aws_s3_bucket s3_logging_bucket {
#   bucket=local.logging_bucket_name
# }
data "aws_s3_bucket" "backend_bucket" {
  bucket = local.backend_bucket
}
data "aws_dynamodb_table" "backend_db" {
  name = local.backend_db
}
# data azurerm_key_vault kv {
#   name=local.vault_name
#   resource_group_name=local.vault_resource_group
# }
locals {
  name = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  #name=lower(replace((length(var.name != null ? var.name : "")>0 ? var.name : "Blessed Beyond Foundation"),"/[^A-Za-z0-9]-/",""))
  backend_bucket           = replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "") > 0 ? var.backend_bucket : "${local.name}-backend-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  backend_db               = replace(replace((length(var.backend_db != null ? var.backend_db : "") > 0 ? var.backend_db : "${local.name}-backend-db"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  codepipeline_bucket_name = replace(replace((length(var.codepipeline_bucket_name != null ? var.codepipeline_bucket_name : "") > 0 ? var.codepipeline_bucket_name : "${local.name}-codepipeline-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  logging_bucket_name      = replace(replace((length(var.logging_bucket_name != null ? var.logging_bucket_name : "") > 0 ? var.logging_bucket_name : "${local.name}-logging-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  pipeline_bucket_name     = replace(replace((length(var.pipeline_bucket_name != null ? var.pipeline_bucket_name : "") > 0 ? var.pipeline_bucket_name : "${local.name}-pipeline-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  website_bucket_name      = replace(replace((length(var.website_bucket_name != null ? var.website_bucket_name : "") > 0 ? var.website_bucket_name : "${local.name}-website-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
module "aws_security_group" {
  source              = "../aws_security_group"
  name                = "${local.name}-allow_ssh"
  description         = "Allow ssh inbound traffic"
  ingress_cidr_blocks = ["203.210.84.220/32"]
}
module "aws_instance" {
  source          = "../aws_instance"
  name            = local.name
  security_groups = ["${module.aws_security_group.name}"]
}
module "logging_bucket" {
  source = "../aws_s3_bucket"
  name   = local.logging_bucket_name
}
module "pipeline_bucket" {
  source = "../aws_s3_bucket"
  name   = local.pipeline_bucket_name
}
module "codepipeline_bucket" {
  source = "../aws_s3_bucket"
  name   = local.codepipeline_bucket_name
}
module "website_bucket" {
  source = "../aws_s3_bucket"
  name   = local.website_bucket_name
}
module "aws_codecommit_repository" {
  source      = "../aws_codecommit_repository"
  name        = "${local.name}-repo"
  description = "${local.name}-repo"
}
# Create an IAM role for CodeBuild to assume
module "codebuild_iam_role" {
  source             = "../aws_iam_role"
  name               = var.codebuild_iam_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
# Create an IAM role policy for CodeBuild to use implicitly
module "codebuild_iam_role_policy" {
  source = "../aws_iam_role_policy"
  name   = var.codebuild_iam_role_policy_name
  role   = module.codebuild_iam_role.name
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${module.logging_bucket.arn}",
        "${module.logging_bucket.arn}/*",
        "${data.aws_s3_bucket.backend_bucket.arn}",
        "${data.aws_s3_bucket.backend_bucket.arn}/*",
        "arn:aws:s3:::codepipeline-us-east-1*",
        "arn:aws:s3:::codepipeline-us-east-1*/*",
        "${module.codepipeline_bucket.arn}",
        "${module.codepipeline_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": "${data.aws_dynamodb_table.backend_db.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:BatchGet*",
        "codecommit:BatchDescribe*",
        "codecommit:Describe*",
        "codecommit:EvaluatePullRequestApprovalRules",
        "codecommit:Get*",
        "codecommit:List*",
        "codecommit:GitPull"
      ],
      "Resource": "${module.aws_codecommit_repository.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:Get*",
        "iam:List*"
      ],
      "Resource": "${module.codebuild_iam_role.arn}"
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${module.codebuild_iam_role.arn}"
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "codepipeline_assume" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codepipeline.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}
module "codepipeline_iam_role" {
  source             = "../aws_iam_role"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume.json
  name               = "${local.name}-pipeline"
}
data "aws_iam_policy_document" "codepipeline" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "codecommit:ListBranches",
      "codecommit:ListRepositories"
    ]
    resources = [
      module.pipeline_bucket.arn,
      "${module.pipeline_bucket.arn}/*",
      module.website_bucket.arn,
      "${module.website_bucket.arn}/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "codecommit:*"
    ]
    resources = [
      module.aws_codecommit_repository.arn,
      "${module.aws_codecommit_repository.arn}/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:Create*",
      "logs:FilterLogEvents",
      "logs:Put*"
    ]
    resources = ["*"]
  }
}
module "codepipeline_iam_role_policy" {
  source = "../aws_iam_role_policy"
  name   = "${local.name}-codepipeline"
  role   = module.codepipeline_iam_role.id
  policy = data.aws_iam_policy_document.codepipeline.json
}
# Create IAM role for Terraform builder to assume
module "tf_iam_assumed_role" {
  source             = "../aws_iam_role"
  name               = "TerraformAssumedIamRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${module.codebuild_iam_role.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    Terraform = "true"
  }
}


# Create broad IAM policy Terraform to use to build, modify resources
module "tf_iam_assumed_policy" {
  source = "../aws_iam_policy"
  name   = "TerraformAssumedIamPolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAllPermissions",
      "Effect": "Allow",
      "Action": [
        "*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach IAM assume role to policy
module "tf_iam_attach_assumed_role_to_permissions_policy" {
  source     = "../aws_iam_role_policy_attachment"
  role       = module.tf_iam_assumed_role.name
  policy_arn = module.tf_iam_assumed_policy.arn
}

module "aws_codebuild_project" {
  source        = "../aws_codebuild_project"
  artifacts     = "CODEPIPELINE"
  build_timeout = "5"
  #cache_type=var.cache_type
  cache_location = local.backend_bucket
  description    = "${local.name}-project"
  #compute_type="BUILD_GENERAL1_SMALL"
  image                       = "aws/codebuild/standard:2.0"
  type                        = "LINUX_CONTAINER"
  image_pull_credentials_type = "CODEBUILD"
  name                        = "${local.name}-project"
  s3_logs_location            = local.logging_bucket_name
  service_role                = module.codebuild_iam_role.arn
  source_type                 = "CODEPIPELINE"
  source_buildspec            = "buildspec_terraform_plan.yml"
}