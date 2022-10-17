output "id" {
  description = "The id of the azurerm_app_service_source_control provisioned"
  value       = azurerm_app_service_source_control.this.id
}
output "scm_type" {
  description = "The scm_type of the azurerm_app_service_source_control provisioned"
  value       = azurerm_app_service_source_control.this.scm_type
}
output "this" {
  value = azurerm_app_service_source_control.this
}
output "uses_github_action" {
  description = "The uses_github_action of the azurerm_app_service_source_control provisioned"
  value       = azurerm_app_service_source_control.this.uses_github_action
}