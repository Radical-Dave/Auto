variable "user" {
  description = "The user for the aws_iam_user_login_profile"
  type        = string
}
variable "password_reset_required" {
  description = "The password_reset_required for the aws_iam_user_login_profile"
  type        = bool
  default     = true
}
variable "pgp_key" {
  description = "The pgp_key for the aws_iam_user_login_profile"
  type        = string
  default     = null
}