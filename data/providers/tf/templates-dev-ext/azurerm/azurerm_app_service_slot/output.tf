output "id" {
  description = "The id of the azurerm_app_service_slotprovisioned"
  value       = azurerm_app_service_slot.this.id
}
output "default_site_hostname" {
  description = "The default_site_hostname of the azurerm_app_service_slot provisioned - website.azurewebsites.net"
  value       = azurerm_app_service_slot.this.default_site_hostname
}
output "name" {
  description = "The name of the azurerm_app_service_slot provisioned"
  value       = azurerm_app_service_slot.this.name
}
output "custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the azurerm_app_service_slot provisioned"
  value       = azurerm_app_service_slot.this.custom_domain_verification_id
}
output "this" {
  description = "The azurerm_app_service_slot provisioned"
  value       = azurerm_app_service_slot.this
}