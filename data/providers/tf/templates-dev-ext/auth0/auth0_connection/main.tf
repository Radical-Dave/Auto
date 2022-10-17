resource "auth0_connection" "this" {
  name            = var.name
  strategy        = var.strategy
  enabled_clients = var.enabled_clients
}