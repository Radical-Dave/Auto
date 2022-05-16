resource "azurerm_app_service" "webapp" {
  name                     = "smoke-test-app"
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  app_service_plan_id      = azurerm_app_service_plan.appserviceplan.id
  app_settings = {
    "WEBSITE_DNS_SERVER": "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL": "1"
  }
    tags = {
    environment = "dev"
    costcenter  = "it"
  }
  depends_on = [azurerm_resource_group.resourcegroup]
}