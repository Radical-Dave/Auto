locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0, 63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_project_pipeline_settings" "this" {
  name       = local.name
  project_id = var.project_id
  initialization {
    init_type = "Clean"
  }
  #location  = var.location
  #tags      = var.tags 
}