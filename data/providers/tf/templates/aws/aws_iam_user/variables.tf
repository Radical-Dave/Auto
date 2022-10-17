variable "force_destroy" {
  description = "The force_destroy for the aws_iam_user (default:false)"
  type        = bool
  default     = false
}
variable "name" {
  description = "The name for the aws_iam_user"
  type        = string
}
variable "path" {
  description = "The path for the aws_iam_user"
  type        = string
  default     = "/"
}
variable "permissions_boundary" {
  description = "The name for the aws_iam_user"
  type        = string
  default     = null
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the aws_iam_user"
  type        = map(string)
  default     = {}
}