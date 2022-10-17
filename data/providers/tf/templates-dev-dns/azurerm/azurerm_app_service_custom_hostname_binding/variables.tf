variable "app_service_name" {
  description = "The name of the AppService"
  type        = string
  default     = null
}
variable "hostname" {
  description = "The hostname of the azurerm_app_service_custom_hostname_binding"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the azurerm_app_service_custom_hostname_binding"
  type        = string
  default     = null
}
variable "ssl_state" {
  description = "The ssl_state of the azurerm_app_service_custom_hostname_binding"
  type        = string
  default     = null
}
variable "thumbprint" {
  description = "The thumbprint of the azurerm_app_service_custom_hostname_binding"
  type        = string
  default     = null
}