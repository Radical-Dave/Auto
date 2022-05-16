data "azurerm_subscription" "primary" {
}
locals {
  # name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
  scopes = length(var.scopes) > 0 ? var.scopes : [data.azurerm_subscription.primary.id]
}
resource "azurerm_role_definition" "this" {
  description = var.azure_role_description
  name = var.azure_role_name  
  scope = data.azurerm_subscription.primary.id
  assignable_scopes = local.scopes
  dynamic "permissions" {
    for_each = var.permissions != null ? [true] : []
    content {
      actions = var.permissions.actions
      data_actions = var.permissions.data_actions
      not_actions = var.permissions.not_actions
      not_data_actions = var.permissions.not_data_actions
    }
  }
}