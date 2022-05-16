locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_variable_group" "this" {
  name      = local.name
  description = var.description
  version_control = var.version_control
  visibility = var.visibility
  work_item_template = var.work_item_template
  features = var.features  
}