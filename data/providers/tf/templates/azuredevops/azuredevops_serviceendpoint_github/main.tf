locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_serviceendpoint_github" "this" {
  service_endpoint_name = local.name
  project_id = var.project_id
  initialization {
    init_type = "Clean"
  }

  #auth_oauth = var.auth_oauth
  #auth_personal = var.auth_personal    
  
  #location  = var.location
  #tags      = var.tags 
}