variable "groups" {
  description = "The groups for the aws_iam_user_group_membership"
  type        = list(string)
}
variable "user" {
  description = "The user for the aws_iam_user_group_membership"
  type        = string
}