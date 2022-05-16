output "id" {
  description = "The id of the app service provisioned"
  value = azurerm_app_service.this.id
}
output "default_site_hostname" {
  description = "The default_site_hostname of the app service provisioned - website.azurewebsites.net"
  value = azurerm_app_service.this.default_site_hostname
}
output "name" {
  description = "The name of the app service provisioned"
  value = azurerm_app_service.this.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the app service provisioned"
  value = azurerm_app_service.this.custom_domain_verification_id
}
output "this" {
  value = azurerm_app_service.this
}