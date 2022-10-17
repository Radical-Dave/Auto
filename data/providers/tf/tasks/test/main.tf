data "azurerm_client_config" "current" {}
#data azuredevops_client_config current {}
module "azuredevops_user_entitlement" {
  source         = "../../templates/azuredevops/azuredevops_user_entitlement"
  principal_name = "david.walker_revunit.com#EXT#@project.onmicrosoft.com"
  #principal_name = data.azurerm_client_config.current.object_id
  #name = var.azdo_project
  #resource_group_name = "core-devops" #var.resource_group_name
  #location = var.location
}
# resource azuredevops_project this {
#   name = var.azdo_project
#   description = var.description
#   version_control = "git"
#   visibility = "private"
#   work_item_template = "Agile"
#   features = {
#     "boards" = "enabled"
#     "repositories" = "enabled"
#     "pipelines" = "enabled"
#     "testplans" = "enabled"
#     "artifacts" = "enabled"
#   } 
# }