variable "name" {
  description = "The name for the aws_security_group"
  type        = string
}
variable "description" {
  description = "The description for the aws_security_group"
  type        = string
  default     = null
}
variable "ingress_from_port" {
  description = "The ingress_from_port for the aws_security_group"
  type        = number
  default     = 22
}
variable "ingress_to_port" {
  description = "The ingress_to_port for the aws_security_group"
  type        = number
  default     = 22
}
variable "ingress_protocol" {
  description = "The ingress_protocol for the aws_security_group"
  type        = string
  default     = "tcp"
}
variable "ingress_cidr_blocks" {
  description = "The ingress_cidr_blocks for the aws_security_group"
  type        = list(string)
  default     = null
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the aws_security_group"
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "The vpc_id for the aws_security_group"
  type        = string
  default     = null
}