terraform {
  experiments = [module_variable_optional_attrs]
}
locals {
  name = replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0,63) : var.name) : "${var.resource_group_name}-acg", " ", ""), "-", "")
}
resource "azurerm_container_group" "this" {
  name = local.name
  resource_group_name = var.resource_group_name
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, )    
}