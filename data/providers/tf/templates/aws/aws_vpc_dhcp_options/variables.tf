variable "dhcp_options_domain_name" {
  description = "The dhcp_options_domain_name for the aws_vpc_dhcp_options"
  type        = string
  default     = ""
}
variable "dhcp_options_domain_name_servers" {
  description = "List of DNS Server addresses for DHCP options set, default to AmazonProvidedDNS (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}
variable "dhcp_options_ntp_servers" {
  description = "List of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}
variable "dhcp_options_netbios_name_servers" {
  description = "List of netbios servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}
variable "dhcp_options_netbios_node_type" {
  description = "The netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the aws_vpc_dhcp_options"
  type        = string
  default     = null
}
variable "tags" {
  description = "Additional tags for the aws_vpc_dhcp_options"
  type        = map(string)
  default     = {}
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
