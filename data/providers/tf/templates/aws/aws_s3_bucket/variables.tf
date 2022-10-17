variable "name" {
  description = "The name for the aws_s3_bucket"
  type        = string
}
variable "bucket_prefix" {
  description = "The bucket_prefix for the aws_s3_bucket"
  type        = string
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_s3_bucket"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "versioning" {
  description = "The versioning for the aws_s3_bucket"
  type        = string
  default     = true
}