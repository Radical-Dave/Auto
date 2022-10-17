output "id" {
  description = "The id of the azurerm_app_service_certificate_binding provisioned"
  value       = azurerm_app_service_certificate_binding.this.id
}
output "app_service_name" {
  description = "The app_service_name of the azurerm_app_service_certificate_binding provisioned"
  value       = azurerm_app_service_certificate_binding.this.app_service_name
}
output "hostname" {
  description = "The hostname of the azurerm_app_service_certificate_binding provisioned"
  value       = azurerm_app_service_certificate_binding.this.hostname
}
output "thumbprint" {
  description = "The thumbprint of the azurerm_app_service_certificate_binding provisioned"
  value       = azurerm_app_service_certificate_binding.this.thumbprint
}