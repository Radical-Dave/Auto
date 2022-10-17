variable "vpc_id" {
  description = "The vpc_id for the aws_route"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_route_table"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}