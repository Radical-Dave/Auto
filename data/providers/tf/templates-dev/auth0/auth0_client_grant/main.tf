resource "auth0_client_grant" "this" {
  audience  = var.audience
  client_id = var.client_id
  scope     = var.scope
}