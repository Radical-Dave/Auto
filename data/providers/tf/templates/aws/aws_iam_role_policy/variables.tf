variable "name" {
  description = "The name for the aws_iam_role_policy"
  type        = string
}
variable "policy" {
  description = "The policy for the aws_iam_role_policy"
  type        = string
  default     = null
}
variable "role" {
  description = "The role for the aws_iam_role_policy"
  type        = string
}