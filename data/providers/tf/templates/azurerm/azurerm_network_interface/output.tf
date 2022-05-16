output "id" {
  description = "The id of the network_interface provisioned"
  value = "${azurerm_network_interface.this.id}"
}
# output "internal_fqdn" {
#   description = "The fqdn of the network_interface provisioned"
#   value = "${azurerm_network_interface.this.internal_fqdn}"
# }
output "mac_address" {
  description = "The mac_address of the network_interface provisioned"
  value = "${azurerm_network_interface.this.mac_address}"
}
output "name" {
  description = "The name of the network_interface provisioned"
  value = "${azurerm_network_interface.this.name}"
}
output "private_ip_address" {
  description = "The private_ip_address of the network_interface provisioned"
  value = "${azurerm_network_interface.this.private_ip_address}"
}
output "applied_dns_servers" {
  description = "The applied_dns_servers of the network_interface provisioned"
  value = "${azurerm_network_interface.this.applied_dns_servers}"
}
output "virtual_machine_id" {
  description = "The virtual_machine_id of the network_interface provisioned"
  value = "${azurerm_network_interface.this.virtual_machine_id}"
}