resource "azurerm_function_app" "azfunction" {
  name                       = "smoke-test-azure-function"
  location                   = azurerm_resource_group.resourcegroup.location
  resource_group_name        = azurerm_resource_group.resourcegroup.name
  app_service_plan_id        = azurerm_app_service_plan.resourcegroup.id
  storage_account_name       = azurerm_storage_account.resourcegroup.name
  storage_account_access_key = azurerm_storage_account.resourcegroup.primary_access_key
    tags = {
    environment = "dev"
    costcenter  = "it"
  }
  depends_on = [azurerm_resource_group.resourcegroup]
}
