output "client_id" {
  description = "The client_id of the auth0_client provisioned"
  value       = auth0_client.this.client_id
}
output "client_secret" {
  description = "The client_secret of the auth0_client provisioned"
  value       = auth0_client.this.client_secret
}
output "is_first_party" {
  description = "The is_first_party of the auth0_client provisioned"
  value       = auth0_client.this.is_first_party
}
output "is_token_endpoint_ip_header_trusted" {
  description = "The is_token_endpoint_ip_header_trusted of the auth0_client provisioned"
  value       = auth0_client.this.is_token_endpoint_ip_header_trusted
}
output "oidc_conformant" {
  description = "The oidc_conformant of the auth0_client provisioned"
  value       = auth0_client.this.oidc_conformant
}
output "grant_types" {
  description = "The grant_types of the auth0_client provisioned"
  value       = auth0_client.this.grant_types
}
output "custom_login_page_on" {
  description = "The custom_login_page_on of the auth0_client provisioned"
  value       = auth0_client.this.custom_login_page_on
}
output "token_endpoint_auth_method" {
  description = "The token_endpoint_auth_method of the auth0_client provisioned"
  value       = auth0_client.this.token_endpoint_auth_method
}
# output "signing_keys" {
#   description = "The signing_keys of the auth0_client provisioned"
#   value = auth0_client.this.signing_keys
# }