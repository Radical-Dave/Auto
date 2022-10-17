output "id" {
  description = "The id of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.id
}
output "name" {
  description = "The name of the log analytics workspace provisioned"
  value       = azurerm_log_analytics_workspace.this.name
}