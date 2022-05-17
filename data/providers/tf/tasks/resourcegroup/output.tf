output "ResourceGroupId" {
  description = "The id of the resource group provisioned"
  value = module.azurerm_resource_group.id
}
output "ResourceGroupName" {
  description = "The name of the resource group provisioned"
  value = module.azurerm_resource_group.name
}