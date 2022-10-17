output "id" {
  description = "The id of the subnet provisioned"
  value       = azurerm_subnet.this.id
}
output "name" {
  description = "The name of the subnet provisioned"
  value       = azurerm_subnet.this.name
}