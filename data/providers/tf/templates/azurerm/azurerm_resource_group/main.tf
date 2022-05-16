locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azurerm_resource_group" "this" {
  name      = local.name
  location  = var.location
  tags      = var.tags 
}