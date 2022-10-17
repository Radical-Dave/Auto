output "id" {
  description = "The id of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.id
}
output "identifier" {
  description = "The identifier of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.identifier
}
output "signing_alg" {
  description = "The signing_alg of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.signing_alg
}
output "signing_secret" {
  description = "The signing_secret of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.signing_secret
}
output "token_lifetime" {
  description = "The token_lifetime of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.token_lifetime
}
output "token_lifetime_for_web" {
  description = "The token_lifetime_for_web of the auth0_resource_server provisioned"
  value       = auth0_resource_server.this.token_lifetime_for_web
}