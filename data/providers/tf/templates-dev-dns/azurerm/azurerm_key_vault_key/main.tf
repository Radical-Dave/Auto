data "azurerm_client_config" "current" {}
locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-kvk"
}

resource "azurerm_key_vault_key" "this" {
  name         = local.name
  key_vault_id = var.azure_key_vault_id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_opts
}