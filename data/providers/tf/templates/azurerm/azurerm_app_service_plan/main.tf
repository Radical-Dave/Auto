locals {
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-asp" : "asp")
  location = coalesce(var.location, "eastus")
}
resource "azurerm_app_service_plan" "this" {  
  name = local.name
  location = local.location
  resource_group_name = var.resource_group_name
  kind = var.kind
  reserved = var.reserved
  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
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