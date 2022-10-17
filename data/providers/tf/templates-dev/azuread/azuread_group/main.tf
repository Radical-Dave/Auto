data "azuread_client_config" "current" {}
locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "-group") > 0 ? var.resource_group_name : "group"
}
resource "azuread_group" "this" {
  display_name     = local.name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = var.security_enabled
  #tags = var.tags 
}