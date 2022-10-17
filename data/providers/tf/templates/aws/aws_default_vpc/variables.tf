variable "name" {
  description = "The name for the aws_default_vpc"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_default_vpc"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}