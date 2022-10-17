variable "egress" {
  description = "The egress for the aws_network_acl_rule"
  type        = bool
  default     = false
}
variable "network_acl_id" {
  description = "The network_acl_id for the aws_network_acl_rule"
  type        = string
}
variable "rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
variable "tags" {
  description = "Additional tags for the aws_network_acl_rule"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}