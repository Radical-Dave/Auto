data "azuread_client_config" "current" {}
locals {
  name      = length(var.name) > 0 ? var.name : "${var.resource_group_name}-sp"
  tenant_id = length(var.tenant_id) > 0 ? var.tenant_id : data.azuread_client_config.current.tenant_id
}
resource "azuread_application" "this" {
  display_name     = local.name
  identifier_uris  = ["http://${local.name}"]
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience
}
resource "azuread_service_principal" "this" {
  alternative_names            = var.alternative_names
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
  description                  = var.description
  # feature_tags {
  #   enterprise=true
  #   gallery   =true
  # }
}