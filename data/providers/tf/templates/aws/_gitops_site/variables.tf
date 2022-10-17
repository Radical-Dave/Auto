variable "backend_bucket" {
  description = "The backend_bucket of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-backend-bucket"
}
variable "backend_db" {
  description = "The backend_db of the s3 bucket [Default: {name}-tfstate]"
  type        = string
  default     = "{name}-backend-db"
}
variable "backend_db_arn" {
  description = "The backend_db_arn of the s3 bucket (Globally unique)"
  type        = string
  default     = null
}
variable "backend_key" {
  description = "The backend_key of the s3 bucket [Default: {name}-tfstate]"
  type        = string
  default     = "{name}-backend-key"
}
variable "backend_region" {
  description = "The backend_region of the s3 bucket [Default: us-east-1])"
  type        = string
  default     = "us-east-1"
}
variable "codebuild_iam_role_name" {
  description = "The codebuild_iam_role_name of the codebuild"
  type        = string
  default     = null
}
variable "codebuild_iam_role_policy_name" {
  description = "The codebuild_iam_role_policy_name of the codebuild"
  type        = string
  default     = null
}
variable "codepipeline_bucket_name" {
  description = "The codepipeline_bucket_name of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-codepipeline-bucket"
}
variable "db_name" {
  description = "The db_name of the resource group"
  type        = string
  default     = "{name}-db"
}
variable "logging_bucket_name" {
  description = "The logging_bucket_name of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-logging-bucket"
}
variable "name" {
  description = "The name of the module"
  type        = string
  default     = null
}
variable "pipeline_bucket_name" {
  description = "The pipeline_bucket_name of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-pipeline-bucket"
}
variable "s3_name" {
  description = "The s3_name of the module"
  type        = string
  default     = null
}
variable "website_bucket_name" {
  description = "The website_bucket_name of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-website-bucket"
}