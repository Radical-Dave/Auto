variable "fprcg_name" {
  description = "The name of the firewall policy rule collection group network"
  type        = string
}
variable "priority" {
  description = "The priority of the firewall policy rule collection group network"
  type        = number
  default     = 100
}
variable "location" {
  description = "The location of the firewall policy rule collection group"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "tags" {
  description = "Tags for the firewall policy rule collection group"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}