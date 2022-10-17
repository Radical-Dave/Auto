locals {
  name = substr(replace(replace(length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}ac", " ", ""), "-", ""), 0, 50)
}
resource "azurerm_app_configuration" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = format("%s", local.name) }, var.tags, )
}