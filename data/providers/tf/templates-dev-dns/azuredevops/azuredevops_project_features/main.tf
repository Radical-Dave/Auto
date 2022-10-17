locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0, 63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_project_features" "this" {
  project_id = var.project_id
  features   = var.features
}