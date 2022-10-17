resource "random_password" "sql_user" {
  count            = length(var.dbserver_login != null ? var.dbserver_login : "") == 0 ? 1 : 0
  length           = 24
  override_special = "%@!"
  special          = true
}
resource "random_password" "sql_password" {
  count            = length(var.dbserver_pwd != null ? var.dbserver_pwd : "") == 0 ? 1 : 0
  length           = 16
  min_numeric      = 2
  min_special      = 2
  override_special = "_%@!"
  special          = true
}
data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
# data external sql_password {
#   program=[
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.sql_password.value)}"
#     "echo", "${data.azurerm_key_vault_secret.sql_password.value}"
#   ]
# }
resource "azurerm_key_vault_secret" "sql_password" {
  depends_on = [data.azurerm_key_vault.kv]
  #count=length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-password" #"mssql-server-password"
  value        = length(var.dbserver_pwd != null ? var.dbserver_pwd : "") > 0 ? var.dbserver_pwd : random_password.sql_password[0].result
  #tags=merge(local.common_tags, tomap({"type"="key_vault_secret_password"}), tomap({"resource"=azurerm_mssql_server.this.name}))
  tags = merge(var.tags, tomap({ "type" = "key_vault_secret_password" }))
}
resource "azurerm_key_vault_secret" "sql_user" {
  depends_on = [data.azurerm_key_vault.kv]
  #count=length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-user" #"mssql-server-password"
  value        = length(var.dbserver_login != null ? var.dbserver_login : "") > 0 ? var.dbserver_login : random_password.sql_user[0].result
  #tags=merge(local.common_tags, tomap({"type"="key_vault_secret_password"}), tomap({"resource"=azurerm_mssql_server.this.name}))
  tags = merge(var.tags, tomap({ "type" = "key_vault_secret_user" }))
}
module "db_connectionstring" {
  source       = "../azurerm_key_vault_secret"
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-connectionstring"
  value        = local.connection_string
}
# resource azurerm_key_vault_secret" "db_connectionstring" {
#   name="${local.name}-connectionstring"
#   #;Initial Catalog=${module.azurerm_mssql_database.database_name}
#   value=local.connection_string
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
locals {
  connection_string    = "Server=tcp:${local.name}.database.windows.net,1433;Persist Security Info=False;User ID=${local.user};Password=${local.password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  name                 = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-dbs" : "project-${var.resource_group_name}-dbs" : "project-dbs"
  password             = coalesce(var.dbserver_pwd, azurerm_key_vault_secret.sql_password.value)
  user                 = coalesce(var.dbserver_login, azurerm_key_vault_secret.sql_user.value)
  vault_name           = length(var.vault_name != null ? var.vault_name : "") > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  vault_resource_group = length(var.vault_resource_group != null ? var.vault_resource_group : "") > 0 ? var.vault_resource_group : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
}
resource "azurerm_mssql_server" "this" {
  depends_on                   = [azurerm_key_vault_secret.sql_password]
  administrator_login          = local.user
  administrator_login_password = local.password #azurerm_key_vault_secret.sql_password.value #local.password
  location                     = var.location
  name                         = local.name
  resource_group_name          = var.resource_group_name
  tags                         = var.tags
  version                      = var.dbserver_version
  #throws error that local.user already exists
  # azuread_administrator {
  #   login_username=local.user
  #   # object_id=azuread_user.database.object_id
  #   object_id=data.azurerm_client_config.current.object_id
  # } 
}
# resource azurerm_sql_firewall_rule azrule {
#   depends_on=[azurerm_mssql_server.this]
#   name="AllowAllWindowsAzureIps"
#   resource_group_name=var.resource_group_name
#   server_name=azurerm_mssql_server.this.name
#   start_ip_address="0.0.0.0"
#   end_ip_address="0.0.0.0"
# }
resource "azurerm_mssql_firewall_rule" "azrule" {
  depends_on = [azurerm_mssql_server.this]
  name       = "AllowAllWindowsAzureIps"
  #resource_group_name=var.resource_group_name
  #server_name=azurerm_mssql_server.this.name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}