variable "minimum_password_length" {
  description = "The minimum_password_length for the aws_iam_account_password_policy"
  type        = number
  default     = 8
}
variable "require_lowercase_characters" {
  description = "The require_lowercase_characters for the aws_iam_account_password_policy"
  type        = bool
  default     = true
}
variable "require_numbers" {
  description = "The require_numbers for the aws_iam_account_password_policy"
  type        = bool
  default     = true
}
variable "require_uppercase_characters" {
  description = "The require_uppercase_characters for the aws_iam_account_password_policy"
  type        = bool
  default     = true
}
variable "require_symbols" {
  description = "The require_symbols for the aws_iam_account_password_policy"
  type        = bool
  default     = true
}
variable "allow_users_to_change_password" {
  description = "The allow_users_to_change_password for the aws_iam_account_password_policy"
  type        = bool
  default     = true
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the aws_iam_group_policy_attachment"
  type        = map(string)
  default     = {}
}