variable "subnet_ids" {
  description = "The subnet_ids for the aws_db_subnet_group"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_network_acl"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "The vpc_id block for the aws_network_acl"
  type        = string
}