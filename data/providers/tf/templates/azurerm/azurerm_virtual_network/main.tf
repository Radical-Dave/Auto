locals {
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-vnet" : "vnet")
  location = coalesce(var.location, "eastus")
}
resource "azurerm_virtual_network" "this" {
  name = local.name
  location = local.location
  resource_group_name = var.resource_group_name
  address_space = var.addresses
  tags = var.tags
}