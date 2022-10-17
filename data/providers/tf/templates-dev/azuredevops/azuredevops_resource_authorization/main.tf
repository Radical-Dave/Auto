resource "azuredevops_resource_authorization" "this" {
  authorized  = var.authorized
  project_id  = var.project_id
  resource_id = var.resource_id
}