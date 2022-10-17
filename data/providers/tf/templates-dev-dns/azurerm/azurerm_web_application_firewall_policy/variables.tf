variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "custom_rules" {
  description = "The addresses of the virtual network"
}
variable "policy_settings" {
  description = "match_conditions for the virtual network"
}
variable "managed_rules" {
  description = "match_conditions for the virtual network"
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}