locals {
  display_name = length(var.display_name != null ? var.display_name : "") > 0 ? var.display_name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "app"
}
resource "azuredevops_group" "this" {
  display_name = local.display_name
  description = var.description
  mail = var.mail
  members = var.members
  origin_id = var.origin_id
  scope = var.scope  
}