variable "cidr" {
  description = "The CIDR block for the aws_route"
  type        = string
  default     = "10.0.0.0/16"
}
variable "destination_ipv6_cidr_block" {
  description = "The destination_ipv6_cidr_block block for the aws_route"
  type        = string
  default     = "10.0.0.0/16"
}
variable "gateway_id" {
  description = "The gateway_id for the aws_route"
  type        = string
  default     = null
}
variable "route_table_id" {
  description = "The route_table_id for the aws_route"
  type        = string
  default     = null
}
variable "aws_route_table_id" {
  description = "The aws_route_table_id for the aws_route"
  type        = string
}
variable "tags" {
  description = "Additional tags for the aws_route"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}