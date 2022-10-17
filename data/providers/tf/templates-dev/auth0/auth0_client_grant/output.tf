output "client_id" {
  description = "The client_id of the auth0_client_grant provisioned"
  value       = auth0_client_grant.this.client_id
}