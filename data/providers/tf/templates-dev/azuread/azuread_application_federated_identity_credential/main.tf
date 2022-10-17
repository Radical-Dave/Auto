data "azuread_client_config" "current" {}
locals {
  #name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
  display_name = length(var.display_name != null ? var.display_name : "") > 0 ? var.display_name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "app"
}
resource "azuread_application_federated_identity_credential" "this" {
  application_object_id = var.application_object_id
  audiences             = var.audiences
  display_name          = local.display_name
  description           = var.description
  issuer                = var.issuer
  subject               = var.subject
}