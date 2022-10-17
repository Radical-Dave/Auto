variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}
variable "nat_gateway_count" {
  description = "The nat_gateway_count block for the VPC"
  type        = number
  default     = 0
}
variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
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