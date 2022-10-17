output "id" {
  description = "The id of the storageaccount provisioned"
  value       = azurerm_storage_account.this.id
}
output "name" {
  description = "The name of the storageaccount provisioned"
  value       = azurerm_storage_account.this.name
}
output "endpoint" {
  description = "The endpoint of the storageaccount provisioned"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
output "key" {
  description = "The key of the storageaccount provisioned"
  value       = azurerm_storage_account.this.primary_access_key
}