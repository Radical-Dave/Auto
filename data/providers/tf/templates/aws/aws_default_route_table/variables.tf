variable "cidr" {
  description = "The CIDR block for the aws_default_route_table"
  type        = string
  default     = "10.0.0.0/16"
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "vpc_tags" {
  description = "Additional tags for the aws_default_route_table"
  type        = map(string)
  default     = {}
}