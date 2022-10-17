output "id" {
  description = "The id of the resource group provisioned"
  value       = azurerm_resource_group.this.id
}
output "location" {
  description = "The location of the resource group provisioned"
  value       = azurerm_resource_group.this.location
}
output "name" {
  description = "The name of the resource group provisioned"
  value       = azurerm_resource_group.this.name
}