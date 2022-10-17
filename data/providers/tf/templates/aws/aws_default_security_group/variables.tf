variable "create_vpc" {
  description = "The create_vpc for the aws_default_security_group"
  type        = string
}
variable "manage_default" {
  description = "The manage_default for the aws_default_security_group"
  type        = string
}
variable "name" {
  description = "The name for the aws_default_security_group"
  type        = string
}
variable "vpc_id" {
  description = "The vpc_id for the aws_default_security_group"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_default_security_group"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}