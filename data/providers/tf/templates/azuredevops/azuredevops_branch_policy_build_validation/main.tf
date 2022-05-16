locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_build_definition" "this" {
  name = local.name
  #agent_pool_name = var.agent_pool_name
  ci_trigger { use_yaml = true }
  project_id = var.project_id
  #location  = var.location
  #tags      = var.tags 
  repository {
    repo_type = "TfsGit"
    repo_id = var.repo_id
    branch_name = var.branch_name
    yml_path = "./BuildDefinitions/default.yml"
  }
  variable_groups = var.variable_groups
}