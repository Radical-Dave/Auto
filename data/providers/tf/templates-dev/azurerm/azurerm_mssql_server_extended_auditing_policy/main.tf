resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  enabled                                 = var.enabled
  log_monitoring_enabled                  = var.log_monitoring_enabled
  retention_in_days                       = 7
  server_id                               = var.server_id
  storage_endpoint                        = var.storage_endpoint
  storage_account_access_key              = var.storage_account_access_key
  storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
}