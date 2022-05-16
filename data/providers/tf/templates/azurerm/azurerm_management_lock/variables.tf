variable "resource_group_name" {
  description = "The name of the azurerm_management_lock"
  type        = string
}
variable "location" {
  description = "The location of the azurerm_management_lock"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azurerm_management_lock"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}