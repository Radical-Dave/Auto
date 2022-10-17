resource "auth0_role" "this" {
  name        = var.name
  description = var.description
  permissions {
    name                       = var.role
    resource_server_identifier = var.resource_server_id
  }
}