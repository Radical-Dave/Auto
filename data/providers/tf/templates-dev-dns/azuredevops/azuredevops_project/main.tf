# terraform {
#   required_version = ">=0.14"  
#   required_providers {
#     azuredevops = {
#       source = "microsoft/azuredevops"
#       version = ">=0.2.1"
#     }
#   }
# }
# provider azuredevops {
#   org_service_url = var.AZDO_URL
#   personal_access_token = var.AZDO_PAT
# }
locals {
  #name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "project"
}
resource "azuredevops_project" "this" {
  name               = local.name
  description        = var.description
  features           = var.features
  version_control    = var.version_control
  visibility         = var.visibility
  work_item_template = var.work_item_template
}