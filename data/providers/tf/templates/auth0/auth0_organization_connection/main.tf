resource "auth0_organization_connection" "this" {
  assign_membership_on_login = var.assign_membership_on_login
  connection_id              = var.connection_id
  organization_id            = var.organization_id
}