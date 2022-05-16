output "id" {
  description = "The id of the container registry provisioned"
  value = azurerm_container_registry.this.id
}
output "name" {
  description = "The name of the container registry provisioned"
  value = azurerm_container_registry.this.name
}
output "fqdn" {
  value = azurerm_container_registry.this.fqdn
  description = "The ip_address of the user"
}
output "ip_address" {
  value = azurerm_container_registry.this.ip_address
  description = "The ip_address of the user"
}
output "location" {
  value = azurerm_container_registry.this.location
  description = "The ip_address of the user"
}
output "tags" {
  value       = azurerm_container_registry.this.tags
  description = "The ip_address of the user"
}