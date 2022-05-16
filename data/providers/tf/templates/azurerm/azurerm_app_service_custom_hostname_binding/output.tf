output "id" {
  description = "The id of the app service custom hostname binding provisioned"
  value = "${azurerm_app_service_custom_hostname_binding.this.id}"
}
output "virtual_ip" {
  description = "The virtual_ip of the app service custom hostname binding provisioned"
  value = "${azurerm_app_service_custom_hostname_binding.this.virtual_ip}"
}
output "this" {
  value = azurerm_app_service_custom_hostname_binding.this
}