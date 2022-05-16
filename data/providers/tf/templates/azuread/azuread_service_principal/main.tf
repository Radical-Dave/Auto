locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azuread_service_principal" "this" {
  application_id = var.application_id
  #display_name = local.name
  #location = var.location
  #tags = var.tags 
}