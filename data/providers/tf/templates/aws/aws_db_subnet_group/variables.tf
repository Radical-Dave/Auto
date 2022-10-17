variable "cidr" {
  description = "The CIDR block for the aws_db_subnet_group"
  type        = string
  default     = "10.0.0.0/16"
}
variable "name" {
  description = "The name for the aws_db_subnet_group"
  type        = string
}
variable "subnet_ids" {
  description = "The subnet_ids for the aws_db_subnet_group"
  type        = list(string)
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_db_subnet_group"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}