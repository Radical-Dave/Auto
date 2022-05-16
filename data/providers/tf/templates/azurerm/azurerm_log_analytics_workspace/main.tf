locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-hub-logaw1"
}
resource "azurerm_log_analytics_workspace" "this" {
  name = local.name
  location = var.location
  resource_group_name = var.resource_group_name
  sku = var.sku
  retention_in_days = var.retention_in_days
  tags = var.tags
}