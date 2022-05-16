output "id" {
  description = "The id of the azurerm_dns_cname_record provisioned"
  value = "${azurerm_dns_cname_record.this.id}"
}
output "name" {
  description = "The name of the azurerm_dns_cname_record provisioned"
  value = "${azurerm_dns_cname_record.this.name}"
}