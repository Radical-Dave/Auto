variable "name" {
  description = "The name of the azurerm_network_security_rule"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}
variable "access" {
  description = "The access of the azurerm_network_security_rule"
  type        = string
  default     = "Allow"
}
variable "description" {
  description = "The description of the azurerm_network_security_rule"
  type        = string
  default     = null
}
variable "destination_port_range" {
  description = "The destination_port_range of the azurerm_network_security_rule"
  type        = string
  default     = 443
}
variable "destination_address_prefix" {
  description = "The destination_address_prefix of the azurerm_network_security_rule"
  type        = string
  default     = null
}
variable "destination_address_prefixes" {
  description = "The destination_address_prefixes of the azurerm_network_security_rule"
  type        = list(string)
  default     = null
}
variable "destination_application_security_group_ids" {
  description = "The destination_application_security_group_ids of the azurerm_network_security_rule"
  type        = list(string)
  default     = null
}
variable "direction" {
  description = "The direction of the azurerm_network_security_rule"
  type        = string
  default     = "Inbound"
}
variable "network_security_group_name" {
  description = "The network_security_group_name of the azurerm_network_security_rule"
  type        = string
  #  default=null
}
variable "priority" {
  description = "The priority of the azurerm_network_security_rule"
  type        = string
  default     = 102
}
variable "protocol" {
  description = "The protocol of the azurerm_network_security_rule"
  type        = string
  default     = "Tcp"
}
variable "source_address_prefix" {
  description = "The source_address_prefix of the azurerm_network_security_rule"
  type        = string
  default     = null
}
variable "source_address_prefixes" {
  description = "The source_address_prefixes of the azurerm_network_security_rule"
  type        = list(string)
  default     = null
}
variable "source_application_security_group_ids" {
  description = "The source_application_security_group_ids of the azurerm_network_security_rule"
  type        = list(string)
  default     = null
}
variable "source_port_range" {
  description = "The source_port_range of the azurerm_network_security_rule"
  type        = string
  default     = 443
}
# variable destination_port_range {
#   description="The destination_port_range of the azurerm_network_security_rule"
#   type=string
#   default=null
# }
variable "tags" {
  description = "Tags for the azurerm_network_security_rule"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}