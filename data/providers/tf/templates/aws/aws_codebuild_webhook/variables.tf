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
variable "compute_type" {
  description = "The compute_type for the aws_codebuild_project"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}
variable "git_clone_depth" {
  description = "The git_clone_depth for the aws_codebuild_project"
  type        = number
  default     = 1
}
variable "image" {
  description = "The imagek for the aws_codebuild_project"
  type        = string
  default     = null
}
variable "name" {
  description = "The name block for the aws_codebuild_project"
  type        = string
}
variable "report_build_status" {
  description = "The report_build_status for the aws_codebuild_project"
  type        = bool
  defaul      = true
}
variable "service_role" {
  description = "The service_role for the aws_codebuild_project"
  type        = string
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