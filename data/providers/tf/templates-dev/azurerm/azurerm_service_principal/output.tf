output "id" {
  description = "The id of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.id
}
output "object_id" {
  description = "The id of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.object_id
}
output "type" {
  value = azuread_service_principal.this.type
}