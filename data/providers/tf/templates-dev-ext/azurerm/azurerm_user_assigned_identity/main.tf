locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-user"
}
resource "azurerm_user_assigned_identity" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  provider            = azurerm.acr_sub
  tags                = var.tags
}