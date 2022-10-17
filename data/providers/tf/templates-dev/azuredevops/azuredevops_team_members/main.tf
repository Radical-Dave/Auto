locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "app"
}
resource "azuredevops_team_members" "this" {
  administrators = var.administrators
  members        = var.members
  name           = local.name
  project_id     = var.project_id
}