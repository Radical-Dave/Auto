locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}" : "${var.resource_group_name}-subnet"
}
resource "azurerm_subnet" "this" {
  name                 = local.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}