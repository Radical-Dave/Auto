variable "name" {
  description = "The name for the aws_iam_group"
  type        = string
}
variable "path" {
  description = "The path for the aws_iam_group"
  type        = string
  default     = "/"
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