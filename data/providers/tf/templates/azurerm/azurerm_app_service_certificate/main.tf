locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-ssl"
}
resource "azurerm_app_service_certificate" "this" {
  resource_group_name = var.resource_group_name
  location = var.location
  name = local.name
  pfx_blob = var.pfx_blob
  password = var.password
  app_service_plan_id = var.app_service_plan_id
  key_vault_secret_id = var.key_vault_secret_id
}