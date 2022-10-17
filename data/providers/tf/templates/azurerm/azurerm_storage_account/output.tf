output "id" {
  description = "The id of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.id
}
output "name" {
  description = "The name of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.name
}
output "endpoint" {
  description = "The endpoint of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
output "key" {
  description = "The key of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.primary_access_key
}
output "primary_blob_endpoint" {
  description = "The primary_blob_endpoint of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
output "primary_connection_string" {
  description = "The primary_connection_string of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.primary_connection_string
}
output "primary_location" {
  description = "The primary_location of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.primary_location
}
output "secondary_blob_endpoint" {
  description = "The secondary_blob_endpoint of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.secondary_blob_endpoint
}
output "secondary_connection_string" {
  description = "The secondary_connection_string of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.secondary_connection_string
}
output "secondary_location" {
  description = "The secondary_location of the azurerm_storage_account provisioned"
  value       = azurerm_storage_account.this.secondary_location
}