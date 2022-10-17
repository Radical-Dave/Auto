locals {
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-asp" : "asp"
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
}
resource "azurerm_app_service_plan" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  reserved            = var.reserved
  sku {
    capacity = var.capacity
    tier     = var.tier
    size     = var.size
  }
  tags = var.tags
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