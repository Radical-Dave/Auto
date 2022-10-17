variable "name" {
  description = "The name of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "project_id" {
  description = "The project_id of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "azdo_personal_access_token" {
  description = "The azdo_personal_access_token of the azuredevops_serviceendpoint_azurerm"
  type        = string
  default     = null
}
variable "azuredevops_spn_tenantid" {
  description = "The azuredevops_spn_tenantid of the azuredevops_serviceendpoint_azurerm"
  type        = string
  default     = null
}
variable "azurerm_subscription_id" {
  description = "The azurerm_subscription_name of the azuredevops_serviceendpoint_azurerm"
  type        = string
  default     = null
}
variable "azurerm_subscription_name" {
  description = "The azurerm_subscription_name of the azuredevops_serviceendpoint_azurerm"
  type        = string
  default     = null
}
variable "service_prinicpal_key" {
  description = "The service_prinicpal_key of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "service_principal_id" {
  description = "The service_principal_id of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the azuredevops_serviceendpoint_azurerm"
  type        = string
}
variable "location" {
  description = "The location of the azuredevops_serviceendpoint_azurerm"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azuredevops_serviceendpoint_azurerm"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}