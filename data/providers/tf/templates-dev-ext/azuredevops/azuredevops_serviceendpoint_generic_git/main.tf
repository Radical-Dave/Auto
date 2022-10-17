locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "azdo-generic-git"
}
resource "azuredevops_serviceendpoint_generic_git" "this" {
  project_id = var.project_id
  #repository_url = var.repository_url
  service_endpoint_name = local.name
  initialization {
    init_type = "Clean"
  }

  #auth_oauth = var.auth_oauth
  #auth_personal = var.auth_personal    

  #location  = var.location
  #tags      = var.tags 
}