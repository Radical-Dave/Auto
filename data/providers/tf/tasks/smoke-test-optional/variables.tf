variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "aks-test"
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = "azcicdnsg"
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
    resource_group_name         = optional(string)
    network_security_group_name = optional(string)
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
      destination_port_range     = "443"
      source_address_prefix      = "AzureFrontDoor.Backend"
      destination_address_prefix = "VirtualNetwork"
    }
  }
}
variable "frontdoor_name" {
  description = "The name of the front door"
  type        = string
  default     = ""
}
variable "frontdoor_location" {
  description = "The location of the front door"
  type        = string
  default     = "Global"
}
variable "frontdoor_hostname" {
  description = "The host name of the front door"
  type        = string
  default     = ""
}
variable "frontend_endpoint" {
  description = "(Required) Frontend Endpoints for Azure Front Door"
}
variable "frontdoor_routing_rules" {
  description = "(Required) Routing rules for Azure Front Door"
}
variable "frontdoor_loadbalancer" {
  description = "(Required) Load Balancer settings for Azure Front Door"
}
variable "frontdoor_health_probe" {
  description = "(Required) Health Probe settings for Azure Front Door"
}
variable "frontdoor_backend" {
  description = "(Required) Backend settings for Azure Front Door"
}
variable "frontdoor_loadbalancer_enabled" {
  description = "(Required) Enable the load balancer for Azure Front Door"
  type        = bool
  default     = true
}
variable "frontdoor_custom_rules" {
  description = "The addresses of the virtual network"
}
variable "frontdoor_policy_settings" {
  description = "match_conditions for the virtual network"
}
variable "frontdoor_managed_rules" {
  description = "managed_rules for the virtual network"
}