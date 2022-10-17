output "application_tenant_id" {
  description = "The application_tenant_id of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.application_tenant_id
}
output "display_name" {
  description = "The display_name of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.display_name
}
output "homepage_url" {
  description = "The homepage_url of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.homepage_url
}
output "id" {
  description = "The id of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.object_id
}
output "service_principal_names" {
  description = "The service_principal_names of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.service_principal_names
}
output "type" {
  description = "The type of the azuread_service_principal provisioned"
  value       = azuread_service_principal.this.type
}
# output "location" {
#   description = "The location of the azuread_service_principal provisioned"
#   value = azuread_service_principal.this.location
# }
# output "name" {
#   description = "The name of the azuread_service_principal provisioned"
#   value = azuread_service_principal.this.name
# }