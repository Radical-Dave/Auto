variable "custom_hostname_binding_id" {
  description = "The custom_hostname_binding_id of the azurerm_app_service_certificate_binding"
  type        = string
}
variable "tags" {
  description = "Tags for the azurerm_app_service_managed_certificate"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}
variable "timeouts" {
  description = "nested block: NestingSingle, min items: 0, max items: 0"
  type = set(object(
    {
      create = string
      delete = string
      read   = string
      update = string
    }
  ))
  default = []
}