variable "name" {
  description = "The name of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "app_service_plan_id" {
  description = "The app_service_plan_id of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "key_vault_secret_id" {
  description = "The key_vault_secret_id of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "pfx_blob" {
  description = "The pfx_blob of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "password" {
  description = "The password of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azurerm_app_service_certificate"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}