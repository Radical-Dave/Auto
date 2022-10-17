# terraform {
#   experiments=[module_variable_optional_attrs]
# }
locals {
  name = replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0, 63) : var.name) : "${var.resource_group_name}-acg", " ", ""), "-", "")
}
resource "azurerm_container_group" "this" {
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  tags                = merge({ "Name" = format("%s", local.name) }, var.tags, )
  dynamic "container" {
    for_each = var.containers
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory
    }
  }
}