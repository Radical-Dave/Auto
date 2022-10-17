variable "name" {
  description = "The name of the azurerm_app_configuration"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The location of the azurerm_app_configuration"
  type        = string
}
variable "tags" {
  description = "A map of tags to add to resource"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}