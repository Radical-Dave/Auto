variable "billing_mode" {
  description = "The billing_mode for the aws_dynamodb_table [PAY_PER_REQUEST] - Pay per request is cheaper for low-i/o applications, like our TF lock state"
  type        = string
  default     = "PAY_PER_REQUEST"
}
variable "name" {
  description = "The name for the aws_dynamodb_table"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_dynamodb_table"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}