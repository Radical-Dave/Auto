output "id" {
  description = "The id of the virtual-network provisioned"
  value       = azurerm_virtual_network.this.id
}
output "name" {
  description = "The name of the virtual-network provisioned"
  value       = azurerm_virtual_network.this.name
}