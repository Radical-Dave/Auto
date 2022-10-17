output "id" {
  description = "The id of the azurerm_dns_zone provisioned"
  value       = azurerm_dns_zone.this.id
}
output "number_of_record_sets" {
  description = "The number_of_record_sets of the azurerm_dns_zone provisioned"
  value       = azurerm_dns_zone.this.number_of_record_sets
}
output "name_servers" {
  description = "The name_servers of the azurerm_dns_zone provisioned"
  value       = azurerm_dns_zone.this.name_servers
}
output "resource_group_name" {
  description = "The resource_group_name of the azurerm_dns_zone provisioned"
  value       = azurerm_dns_zone.this.resource_group_name
}