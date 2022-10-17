output "id" {
  description = "The id of the auth0_connection provisioned"
  value       = auth0_connection.this.id
}
output "is_domain_connection" {
  description = "The is_domain_connection of the auth0_connection provisioned"
  value       = auth0_connection.this.is_domain_connection
}
output "metadata" {
  description = "The metadata of the auth0_connection provisioned"
  value       = auth0_connection.this.metadata
}
output "options" {
  description = "The options of the auth0_connection provisioned"
  value       = auth0_connection.this.options
}
output "realms" {
  description = "The realms of the auth0_connection provisioned"
  value       = auth0_connection.this.realms
}