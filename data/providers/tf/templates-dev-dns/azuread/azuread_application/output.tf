output "id" {
  description = "The id of the azuread_application provisioned"
  value       = azuread_application.this.id
}
output "application_id" {
  description = "The application_id of the azuread_application provisioned"
  value       = azuread_application.this.application_id
}
output "app_role_ids" {
  description = "The app_role_ids of the azuread_application provisioned"
  value       = azuread_application.this.app_role_ids
}
output "disabled_by_microsoft" {
  description = "The disabled_by_microsoft of the azuread_application provisioned"
  value       = azuread_application.this.disabled_by_microsoft
}
output "logo_url" {
  description = "The logo_url of the azuread_application provisioned"
  value       = azuread_application.this.logo_url
}
output "oauth2_permission_scope_ids" {
  description = "The oauth2_permission_scope_ids of the azuread_application provisioned"
  value       = azuread_application.this.oauth2_permission_scope_ids
}
output "object_id" {
  description = "The object_id of the azuread_application provisioned"
  value       = azuread_application.this.object_id
}
output "publisher_domain" {
  description = "The publisher_domain of the azuread_application provisioned"
  value       = azuread_application.this.publisher_domain
}
# output "location" {
#   description = "The location of the azuread_application provisioned"
#   value = azuread_application.this.location
# }
# output "name" {
#   description = "The name of the azuread_application provisioned"
#   value = azuread_application.this.name
# }