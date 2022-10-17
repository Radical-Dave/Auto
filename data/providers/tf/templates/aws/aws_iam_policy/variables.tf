variable "description" {
  description = "The description for the aws_iam_policy"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the aws_iam_policy"
  type        = string
  default     = null
}
variable "name_prefix" {
  description = "The name_prefix for the aws_iam_policy"
  type        = string
  default     = null
}
variable "path" {
  description = "The path for the aws_iam_policy"
  type        = string
  default     = null
}
variable "policy" {
  description = "The policy for the aws_iam_policy"
  type        = string
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_codepipeline"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}