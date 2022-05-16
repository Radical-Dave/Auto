locals {
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-db" : "db")
}
resource "azurerm_mssql_database" "this" {
  name = local.name
  server_id = var.dbserver_id  
  collation = var.db_collation
  license_type = "LicenseIncluded"
  max_size_gb = var.db_maxsize
  read_scale = var.db_scale
  sku_name = var.db_sku
  tags = var.tags
  zone_redundant = var.db_redundant
  # extended_auditing_policy {
  #   storage_endpoint                        = var.sa_endpoint
  #   storage_account_access_key              = var.sa_key
  #   storage_account_access_key_is_secondary = true
  #   retention_in_days                       = 6
  # }
}