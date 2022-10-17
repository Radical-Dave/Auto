variable "user" {
  description = "The user for the aws_iam_access_key"
  type        = string
}
variable "pgp_key" {
  description = "The pgp_key for the aws_iam_access_key"
  type        = string
  default     = "keybase:terraform_user"
}
variable "status" {
  description = "The status for the aws_iam_access_key"
  type        = string
  default     = "Active"
}