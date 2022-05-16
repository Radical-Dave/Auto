data "azurerm_client_config" "current" {}
locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}kv"
  tenant_id = length(var.tenant_id) > 0 ? var.tenant_id : data.azurerm_client_config.current.tenant_id
}
# module "resourcegroup" {
#   source = "../../templates/resourcegroup"
#   resource_group_name = var.resource_group_name
#   location = var.location
# }
module "azurerm_log_analytics_workspace" {
  source = "../../templates/azurerm/azurerm_log_analytics_workspace"
  resource_group_name = var.resource_group_name
  location = var.location
}
resource "azurerm_key_vault" "this" {
  name = local.name
  location = var.location
  resource_group_name = var.resource_group_name
  tenant_id = local.tenant_id
  enabled_for_deployment = var.enabled_for_deployment
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization = var.enable_rbac_authorization
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  sku_name = var.sku_name
  tags = var.tags
  dynamic "network_acls" {
    for_each = var.network_acls != null ? [true] : []
    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "purge",
      "recover"
    ]

    secret_permissions = [
      "set",
    ]
  }
  timeouts {
    delete = "60m"
  }
}