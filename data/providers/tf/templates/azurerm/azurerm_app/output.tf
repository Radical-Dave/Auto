output "id" {
  description = "The id of the azurerm_app_service provisioned"
  value       = module.azurerm_app_service.id
}
output "default_hostname" {
  description = "The default_hostname of the azurerm_app_service provisioned - website.azurewebsites.net"
  value       = module.azurerm_app_service.default_hostname
}
output "name" {
  description = "The name of the azurerm_app_service provisioned"
  value       = module.azurerm_app_service.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the azurerm_app_service provisioned"
  value       = module.azurerm_app_service.custom_domain_verification_id
}
output "this" {
  value = module.azurerm_app_service
}