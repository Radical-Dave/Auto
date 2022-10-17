variable "domain_name" {
  description = "The domain_name for the aws_cloudfront_distribution"
  type        = string
}
variable "name" {
  description = "The name for the aws_cloudfront_distribution"
  type        = string
}
variable "origin_id" {
  description = "The origin_id for the aws_cloudfront_distribution"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_cloudfront_distribution"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}