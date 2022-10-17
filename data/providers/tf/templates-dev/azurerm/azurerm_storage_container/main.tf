locals {
  name                 = substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}sc" : "project${var.resource_group_name}sc" : "projectsa", "-", ""), 0, 24)
  storage_account_name = substr(length(var.storage_account_name != null ? var.storage_account_name : "") > 0 ? var.storage_account_name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}sc" : "project${var.resource_group_name}sc" : "projectsc", "-", ""), 0, 24)
}
resource "azurerm_storage_container" "this" {
  container_access_type = "private"
  name                  = substr(replace(local.name, "-", ""), 0, 24)
  storage_account_name  = local.storage_account_name
}