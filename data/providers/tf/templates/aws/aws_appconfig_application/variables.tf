variable "description" {
  description = "The description for the aws_appconfig_application"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the aws_appconfig_application"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_appconfig_application"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}