output "id" {
  description = "The id of the azurerm_network_security_rule provisioned"
  value       = azurerm_network_security_rule.this.id
}
output "name" {
  description = "The name of the azurerm_network_security_rule provisioned"
  value       = azurerm_network_security_rule.this.name
}