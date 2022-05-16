output "id" {
  description = "The id of the azurerm_dns_zone provisioned"
  value = "${azurerm_dns_zone.this.id}"
}
output "name" {
  description = "The name of the azurerm_dns_zone provisioned"
  value = "${azurerm_dns_zone.this.name}"
}
output "hostname" {
  description = "The hostname of the azurerm_dns_zone provisioned"
  value = "${local.hostname}"
}