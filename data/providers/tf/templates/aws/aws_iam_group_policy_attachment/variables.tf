variable "groups" {
  description = "The groups for the aws_iam_group_policy_attachment"
  type        = list(string)
  default     = null
}
variable "name" {
  description = "The name for the aws_iam_group_policy_attachment"
  type        = string
}
variable "policy_arn" {
  description = "The policy_arn for the aws_iam_group_policy_attachment"
  type        = string
}
variable "roles" {
  description = "The roles for the aws_iam_group_policy_attachment"
  type        = list(string)
  default     = null
}
variable "users" {
  description = "The users for the aws_iam_group_policy_attachment"
  type        = list(string)
  default     = null
}