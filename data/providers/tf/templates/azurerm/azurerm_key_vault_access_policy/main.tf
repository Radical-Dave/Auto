data "azurerm_client_config" "current" {}
locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-kv"
  tenant_id = length(var.tenant_id) > 0 ? var.tenant_id : data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.agw.id
  tenant_id = local.tenant_id
  object_id    = azurerm_user_assigned_identity.agw.principal_id
  key_permissions = var.key_permissions
  secret_permissions = var.secret_permissions
  tags = var.tags
}