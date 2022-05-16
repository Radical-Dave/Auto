resource "azurerm_mssql_database" "dbtest" {
  name           = "smoke-test-aks-dbtest"
  server_id      = azurerm_mssql_server.dbserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.dbserver.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.dbserver.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_mssql_server.dbserver]
}
