resource "azurerm_mssql_server" "dbserver" {
  name                         = "smoke-test-aks-db"
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  location                     = azurerm_resource_group.resourcegroup.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"

  depends_on = [azurerm_resource_group.resourcegroup, azurerm_storage_account.storageaccount]
}
