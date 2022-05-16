output "id" {
  description = "The id of the app service plan provisioned"
  value = "${azurerm_app_service_plan.this.id}"
}
output "name" {
  description = "The name of the app service plan provisioned"
  value = "${azurerm_app_service_plan.this.name}"
}
output "this" {
  value = azurerm_app_service_plan.this
}