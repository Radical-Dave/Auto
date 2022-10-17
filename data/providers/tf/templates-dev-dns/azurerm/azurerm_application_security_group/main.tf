locals {
  name = length(var.name != null ? var.name : "") > 0 ? "${replace(var.name, "~", "${var.resource_group_name}-")}-asg" : "${var.resource_group_name}-asg"
}
resource "azurerm_application_security_group" "this" {
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
  dynamic "timeouts" {
    for_each = var.timeouts
    content {
      create = timeouts.value["create"]
      delete = timeouts.value["delete"]
      read   = timeouts.value["read"]
      update = timeouts.value["update"]
    }
  }
}