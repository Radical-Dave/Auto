data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
data "azurerm_mssql_server" "server" {
  name                = "${local.name}s"
  resource_group_name = var.resource_group_name
}
locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-db" : "db"
  #"Server=tcp:${data.azurerm_mssql_server.server.name}.database.windows.net,1433;Persist Security Info=False;User ID=${local.user};Password=${local.password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Initial Catalog=${local.name}"
  connection_string = length(var.connection_string != null ? var.connection_string : "") > 0 ? (length(regexall(".*Initial Catalog=.*", var.connection_string)) > 0) ? var.connection_string : "${var.connection_string}Initial Catalog=${local.name};" : ""
  #vault_name=coalesce(var.vault_name, "${var.resource_group_name}-kv")
  #vault_resource_group=length(coalesce(var.vault_resource_group,""))>0 ? var.vault_resource_group : length(coalesce(var.resource_group_name,"")) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
  vault_name           = length(var.vault_name != null ? var.vault_name : "") > 0 ? var.vault_name : "base-terraform-kv"
  vault_resource_group = length(var.vault_resource_group != null ? var.vault_resource_group : "") > 0 ? var.vault_resource_group : "base-terraform-rg"
}
# resource azurerm_key_vault_secret" "db_connectionstring" {
#   name="${local.name}-connectionstring"
#   #;Initial Catalog=${module.azurerm_mssql_database.database_name}
#   value=local.connection_string
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
module "db_connectionstring" {
  source       = "../azurerm_key_vault_secret"
  name         = "${local.name}-connectionstring"
  value        = local.connection_string
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_mssql_database" "this" {
  name           = local.name
  server_id      = var.dbserver_id
  collation      = var.db_collation
  license_type   = "LicenseIncluded"
  max_size_gb    = var.db_maxsize
  read_scale     = var.db_scale
  sku_name       = var.db_sku
  tags           = var.tags
  zone_redundant = var.db_redundant
  # extended_auditing_policy {
  #   storage_endpoint                       =var.sa_endpoint
  #   storage_account_access_key             =var.sa_key
  #   storage_account_access_key_is_secondary=true
  #   retention_in_days                      =6
  # }
  # threat_detection_policy {
  #   state = "Enabled"
  #   email_addresses = [var.sql-threat-email]
  # }
}