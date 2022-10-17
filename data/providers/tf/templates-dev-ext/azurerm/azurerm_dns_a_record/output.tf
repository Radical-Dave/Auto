output "id" {
  description = "The id of the azurerm_dns_a_record provisioned"
  value       = azurerm_dns_a_record.this.id
}
output "name" {
  description = "The name of the azurerm_dns_a_record provisioned"
  value       = azurerm_dns_a_record.this.name
}
output "this" {
  value = azurerm_dns_a_record.this
}