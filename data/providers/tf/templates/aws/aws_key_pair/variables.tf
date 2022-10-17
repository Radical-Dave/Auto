variable "name" {
  description = "The name block for the aws_codepipeline"
  type        = string
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