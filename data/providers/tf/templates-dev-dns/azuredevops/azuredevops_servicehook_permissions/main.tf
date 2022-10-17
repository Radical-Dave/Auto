resource "azuredevops_servicehook_permissions" "this" {
  permissions = var.permissions
  principal   = var.principal
  project_id  = var.project_id
  replace     = var.replace
}