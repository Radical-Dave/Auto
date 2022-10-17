output "id" {
  description = "The id of the azurerm_application_insights provisioned"
  value       = azurerm_application_insights.this.id
}
output "app_id" {
  description = "The app_id of the azurerm_application_insights provisioned"
  value       = azurerm_application_insights.this.app_id
}
output "connection_string" {
  description = "The connection_string of the azurerm_application_insights provisioned"
  value       = azurerm_application_insights.this.connection_string
}
output "instrumentation_key" {
  description = "The instrumentation_key of the azurerm_application_insights provisioned"
  value       = azurerm_application_insights.this.instrumentation_key
}