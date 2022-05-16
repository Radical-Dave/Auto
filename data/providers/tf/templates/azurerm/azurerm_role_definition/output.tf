output "id" {
  description = "The id of the azuread_service_principal provisioned"
  value = azuread_service_principal.this.id
}
output "type" {
  value = azuread_service_principal.this.type
}