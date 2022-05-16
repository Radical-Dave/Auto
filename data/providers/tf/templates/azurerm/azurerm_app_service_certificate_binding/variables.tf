variable "certificate_id" {
  description = "The certificate_id of the azurerm_app_service_certificate_binding"
  type = string
  default = null
}
variable "hostname_binding_id" {
  description = "The hostname_binding_id of the azurerm_app_service_certificate_binding"
  type = string
  default = null
}
variable "ssl_state" {
  description = "The ssl_state of the azurerm_app_service_certificate_binding (IpBasedEnabled or SniEnabled - default)"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}