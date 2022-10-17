output "name" {
  description = "The id of the auth0_organization_connection provisioned"
  value       = auth0_organization_connection.this.name
}
output "strategy" {
  description = "The strategy of the auth0_organization_connection provisioned"
  value       = auth0_organization_connection.this.strategy
}