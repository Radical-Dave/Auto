output "id" {
  description = "The id of the azuread_application_password provisioned"
  value       = azuread_application_password.this.id
}
output "location" {
  description = "The location of the azuread_application_password provisioned"
  value       = azuread_application_password.this.location
}
output "name" {
  description = "The name of the azuread_application_password provisioned"
  value       = azuread_application_password.this.name
}