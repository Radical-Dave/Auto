variable "create_vpc" {
  description = "The create_vpc for the aws_vpc_dhcp_options_association"
  type        = bool
}
variable "enable_dhcp_options" {
  description = "The enable_dhcp_options for the aws_vpc_dhcp_options_association"
  type        = bool
}
variable "dhcp_id" {
  description = "The dhcp_id for the aws_vpc_dhcp_options_association"
  type        = string
}
variable "vpc_id" {
  description = "The vpc_id for the aws_vpc_dhcp_options_association"
  type        = string
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the aws_vpc_dhcp_options_association"
  type        = map(string)
  default     = {}
}