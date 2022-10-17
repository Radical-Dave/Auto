output "id" {
  description = "The id of the azurerm_app_configuration provisioned"
  value       = azurerm_app_configuration.this.id
}
output "identity" {
  description = "The identity of the user"
  value       = azurerm_app_configuration.this.identity
}
output "endpoint" {
  description = "The endpoint of the azurerm_app_configuration provisioned"
  value       = azurerm_app_configuration.this.endpoint
}
output "primary_read_key" {
  description = "The primary_read_key of the user"
  value       = azurerm_app_configuration.this.primary_read_key
}
output "primary_write_key" {
  description = "The primary_write_key of the user"
  value       = azurerm_app_configuration.this.primary_write_key
}
output "secondary_read_key" {
  description = "The secondary_read_key of the user"
  value       = azurerm_app_configuration.this.secondary_read_key
}
output "secondary_write_key" {
  description = "The secondary_write_key of the user"
  value       = azurerm_app_configuration.this.secondary_write_key
}