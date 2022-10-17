resource "azurerm_app_service_certificate_binding" "this" {
  certificate_id      = var.certificate_id
  hostname_binding_id = var.hostname_binding_id
  ssl_state           = var.ssl_state
}