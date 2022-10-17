variable "artifacts" {
  description = "The artifacts block for the aws_codebuild_project"
  type        = string
  default     = "NO_ARTIFACTS"
}
variable "build_timeout" {
  description = "The build_timeout for the aws_codebuild_project"
  type        = number
  default     = 120
}
variable "cache_location" {
  description = "The cache_location for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "cache_type" {
  description = "The cache_type for the aws_codebuild_project"
  type        = string
  default     = "S3"
}
variable "compute_type" {
  description = "The compute_type for the aws_codebuild_project"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}
variable "description" {
  description = "The description for the aws_codecommit_repository"
  type        = string
  default     = null
}
variable "git_clone_depth" {
  description = "The git_clone_depth for the aws_codebuild_project"
  type        = number
  default     = 1
}
variable "group_name" {
  description = "The group_name for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "image" {
  description = "The image for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "image_pull_credentials_type" {
  description = "The image_pull_credentials_type for the aws_codebuild_project"
  type        = string
  default     = "CODEBUILD"
}
variable "name" {
  description = "The name block for the aws_codebuild_project"
  type        = string
}
variable "report_build_status" {
  description = "The report_build_status for the aws_codebuild_project"
  type        = bool
  default     = true
}
variable "s3_logs_enabled" {
  description = "The s3_logs_enabled for the aws_codebuild_project"
  type        = string
  default     = "ENABLED"
}
variable "s3_logs_location" {
  description = "The s3_logs_location for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "service_role" {
  description = "The service_role for the aws_codebuild_project"
  type        = string
}
variable "source_buildspec" {
  description = "The source_buildspec for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "source_location" {
  description = "The source_location for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "source_type" {
  description = "The source_type for the aws_codebuild_project"
  type        = string
  default     = "GITHUB"
}
variable "tags" {
  description = "Additional tags for the aws_codebuild_project"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "type" {
  description = "The type for the aws_codebuild_project"
  type        = string
  default     = "LINUX_CONTAINER"
}