output "id" {
  description = "The id of the azurerm_monitor_diagnostic_setting provisioned"
  value       = azurerm_monitor_diagnostic_setting.this.id
}
# output name {
#   description="The name of the public ip provisioned"
#   value=azurerm_public_ip.this.name
# }
# output ip_address {
#   description="The ip_address of the public ip provisioned"
#   value=azurerm_public_ip.this.ip_address
# }
# output fqdn {
#   description="The fqdn of the public ip provisioned"
#   value=azurerm_public_ip.this.fqdn
# }