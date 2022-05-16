module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  vnet_name           = "smoke-test-aks-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["endpointsubnet", "integrationsubnet"]

  subnet_service_endpoints = {
    endpointsubnet = ["Microsoft.Storage", "Microsoft.Sql"],
    integrationsubnet = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.resourcegroup]
}