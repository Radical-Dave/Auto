variable "name" {
  description = "The name for the aws_internet_gateway"
  type        = string
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the aws_internet_gateway"
  type        = map(string)
  default     = {}
}