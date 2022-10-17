data "azuread_client_config" "current" {}
locals {
  #name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "app"
}
resource "azuread_application" "this" {
  display_name = local.name
  #identifier_uris  = ["api://example-app"]
  #location = var.location
  #logo_image = filebase64)"/path/to/logo.png")
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience
  #tags = var.tags 
}