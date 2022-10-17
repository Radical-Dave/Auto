resource "auth0_resource_server" "this" {
  name                                            = var.name
  identifier                                      = var.identifier
  signing_alg                                     = var.signing_alg
  allow_offline_access                            = var.allow_offline_access
  token_lifetime                                  = var.token_lifetime
  skip_consent_for_verifiable_first_party_clients = var.skip_consent_for_verifiable_first_party_clients
  dynamic "scopes" {
    for_each = var.scopes
    content {
      description = scopes.value.description
      value       = scopes.value.value
    }
  }
}