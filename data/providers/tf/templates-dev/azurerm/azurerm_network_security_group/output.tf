output "id" {
  description = "The id of the azurerm_network_security_group provisioned"
  value       = azurerm_network_security_group.this.id
}
output "name" {
  description = "The name of the azurerm_network_security_group provisioned"
  value       = azurerm_network_security_group.this.name
}