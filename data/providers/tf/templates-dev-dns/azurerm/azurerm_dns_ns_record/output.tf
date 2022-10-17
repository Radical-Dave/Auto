output "id" {
  description = "The id of the app service provisioned"
  value       = azurerm_dns_ns_record.this.id
}
output "name" {
  description = "The name of the app service provisioned"
  value       = azurerm_dns_ns_record.this.name
}