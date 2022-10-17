output "id" {
  description = "The id of the container registry provisioned"
  value       = azurerm_container_group.this.id
}
output "name" {
  description = "The name of the container registry provisioned"
  value       = azurerm_container_group.this.name
}
output "location" {
  value       = azurerm_container_group.this.location
  description = "The ip_address of the user"
}
output "tags" {
  value       = azurerm_container_group.this.tags
  description = "The ip_address of the user"
}