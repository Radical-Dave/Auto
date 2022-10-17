variable "description" {
  description = "The description for the aws_codecommit_repository"
  type        = string
  default     = null
}
variable "name" {
  description = "The name block for the aws_codecommit_repository"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_codecommit_repository"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}