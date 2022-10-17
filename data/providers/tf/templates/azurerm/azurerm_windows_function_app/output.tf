output "id" {
  description = "The id of the azurerm_windows_function_app provisioned"
  value       = azurerm_windows_function_app.this.id
}
output "default_hostname" {
  description = "The default_site_hostname of the azurerm_windows_function_app provisioned - website.azurewebsites.net"
  value       = azurerm_windows_function_app.this.default_hostname
}
output "kind" {
  description = "The kind of the azurerm_windows_function_app provisioned"
  value       = azurerm_windows_function_app.this.kind
}
output "name" {
  description = "The name of the azurerm_windows_function_app provisioned"
  value       = azurerm_windows_function_app.this.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the azurerm_windows_function_app"
  value       = azurerm_windows_function_app.this.custom_domain_verification_id
}
output "this" {
  value = azurerm_windows_function_app.this
}