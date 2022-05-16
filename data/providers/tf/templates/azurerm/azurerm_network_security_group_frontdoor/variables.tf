variable "name" {
  description = "The name of the network security group"
  type = string
  default = ""
}
variable "nsg_rules" {
  description = "The name of the network security group"
  type = map(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
    # resource_group_name         = optional(string)
    # network_security_group_name = optional(string)
  }))
  default = {
    azure-frontdoor = {
      name                       = "azure-frontdoor"
      description                = "Only allow data routed from azure frontdoor into the vnet"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range    = "443"
      source_address_prefix      = "AzureFrontDoor.Backend"
      destination_address_prefix = "VirtualNetwork"
    }
  }
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "location" {
  description = "The location of the resource group"
  type = string
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}