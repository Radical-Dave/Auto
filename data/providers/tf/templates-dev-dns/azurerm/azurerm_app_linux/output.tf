output "id" {
  description = "The id of the app service provisioned"
  value       = module.azurerm_app_service.id
}
output "default_site_hostname" {
  description = "The default_site_hostname of the app service provisioned - website.azurewebsites.net"
  value       = module.azurerm_app_service.default_site_hostname
}
output "name" {
  description = "The name of the app service provisioned"
  value       = module.azurerm_app_service.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the app service provisioned"
  value       = module.azurerm_app_service.custom_domain_verification_id
}
output "this" {
  value = module.azurerm_app_service
}