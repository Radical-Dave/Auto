variable "application_id" {
  description = "The application_id of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "name" {
  description = "The name of the azuread_service_principal"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the azuread_service_principal"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azuread_service_principal"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azuread_service_principal"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}