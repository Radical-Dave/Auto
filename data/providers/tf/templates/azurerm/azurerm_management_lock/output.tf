output "id" {
  description = "The id of the azurerm_management_lock provisioned"
  value = "${azurerm_management_lock.this.id}"
}
output "location" {
  description = "The location of the azurerm_management_lock provisioned"
  value = "${azurerm_management_lock.this.location}"
}
output "name" {
  description = "The name of the azurerm_management_lock provisioned"
  value = "${azurerm_management_lock.this.name}"
}