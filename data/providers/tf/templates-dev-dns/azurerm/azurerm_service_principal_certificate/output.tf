output "id" {
  description = "The id of the azuread_service_principal provisioned"
  value       = [azuread_service_principal_certificate.this.*.id]
}

output "description" {
  description = "The description of the azuread_service_principal provisioned"
  value       = [azuread_service_principal_certificate.this.*.description]
}
