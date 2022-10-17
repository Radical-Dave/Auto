variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "frontdoor_name" {
  description = "The name of the front door"
  type        = string
  default     = null
}
variable "frontdoor_hostname" {
  description = "The hostname of the front door"
  type        = string
  default     = null
}
variable "frontend_endpoint" {
  description = "(Required) Frontend Endpoints for Azure Front Door"
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
variable "frontdoor_certificate_enforced" {
  description = "Enforce the certificate name check for Azure Front Door"
  type        = bool
  default     = true
}
variable "frontdoor_backend_timeout" {
  description = "Set the send/receive timeout for Azure Front Door"
  type        = number
  default     = 60
}
variable "frontdoor_location" {
  description = "The location of the front door"
  type        = string
  default     = "Global"
}
variable "frontdoor_custom_rules" {
  description = "The addresses of the virtual network"
  default     = {}
}
variable "frontdoor_routing_rules" {
  description = "The addresses of the virtual network"
}
variable "frontdoor_policy_settings" {
  description = "match_conditions for the virtual network"
}
variable "frontdoor_managed_rules" {
  description = "managed_rules for the virtual network"
  default     = {}
}
variable "tags" {
  description = "Tags for the front door"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}