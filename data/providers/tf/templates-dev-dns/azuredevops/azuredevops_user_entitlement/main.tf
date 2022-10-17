locals {
  principal_name = length(var.principal_name != null ? var.principal_name : "") > 0 ? var.principal_name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "app"
}
resource "azuredevops_user_entitlement" "this" {
  principal_name       = local.principal_name
  account_license_type = var.account_license_type
}