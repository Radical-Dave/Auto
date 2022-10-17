resource "azurerm_app_service_custom_hostname_binding" "this" {
  app_service_name    = var.app_service_name
  hostname            = var.hostname
  resource_group_name = var.resource_group_name
  ssl_state           = var.ssl_state
  thumbprint          = var.thumbprint
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}