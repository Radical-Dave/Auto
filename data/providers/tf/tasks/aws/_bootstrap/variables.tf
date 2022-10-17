variable "db_name" {
  description = "The subscription_id of the resource group"
  type        = string
  default     = "{name}-db"
}
variable "name" {
  description = "The name of the s3 bucket (Globally unique)"
  type        = string
  default     = null
}
variable "s3_name" {
  description = "The name of the s3 bucket (Globally unique)"
  type        = string
  default     = "{name}-s3"
}