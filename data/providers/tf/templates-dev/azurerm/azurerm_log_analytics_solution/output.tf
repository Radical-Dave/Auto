output "id" {
  description = "The id of the log analytics solution provisioned"
  value       = azurerm_log_analytics_solution.this.id
}
output "name" {
  description = "The name of the log analytics solution provisioned"
  value       = azurerm_log_analytics_solution.this.solution_name
}