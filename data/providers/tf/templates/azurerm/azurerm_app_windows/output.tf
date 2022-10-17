output "id" {
  description = "The id of the azurerm_windows_web_app provisioned"
  value       = module.azurerm_windows_web_app.id
}
output "default_hostname" {
  description = "The default_hostname of the azurerm_windows_web_app provisioned - website.azurewebsites.net"
  value       = module.azurerm_windows_web_app.default_hostname
}
output "name" {
  description = "The name of the azurerm_windows_web_app provisioned"
  value       = module.azurerm_windows_web_app.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the azurerm_windows_web_app provisioned"
  value       = module.azurerm_windows_web_app.custom_domain_verification_id
}
output "this" {
  value = module.azurerm_windows_web_app
}