output "id" {
  description = "The id of the azurerm_storage_container provisioned"
  value       = azurerm_storage_container.this.id
}
output "has_immutability_policy" {
  description = "The has_immutability_policy of the azurerm_storage_container provisioned"
  value       = azurerm_storage_container.this.has_immutability_policy
}
output "has_legal_hold" {
  description = "The has_legal_hold of the azurerm_storage_container provisioned"
  value       = azurerm_storage_container.this.has_legal_hold
}
output "resource_manager_id" {
  description = "The resource_manager_id of the azurerm_storage_container provisioned"
  value       = azurerm_storage_container.this.resource_manager_id
}