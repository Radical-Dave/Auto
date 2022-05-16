output "ResourceGroupId" {
  description = "The id of the resource group provisioned"
  value = "${azurerm_resource_group.rg.id}"
}
output "ResourceGroupName" {
  description = "The name of the resource group provisioned"
  value = "${azurerm_resource_group.rg.name}"
}