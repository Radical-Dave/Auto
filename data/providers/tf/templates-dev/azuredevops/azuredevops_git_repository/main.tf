locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0, 63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_git_repository" "this" {
  name       = local.name
  project_id = var.project_id
  initialization {
    init_type = "Clean" #Import
    #source_type = "Git"
    #source_url = "https://github.com/URL"
  }
  #location  = var.location
  #tags      = var.tags 
}