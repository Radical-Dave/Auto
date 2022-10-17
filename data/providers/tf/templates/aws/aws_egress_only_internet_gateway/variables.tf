variable "vpc_id" {
  description = "The id for the aws_egress_only_internet_gateway"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_egress_only_internet_gateway"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}