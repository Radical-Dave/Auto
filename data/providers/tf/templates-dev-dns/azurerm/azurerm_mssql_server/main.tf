resource "random_password" "sql_user" {
  count            = length(var.dbserver_login != null ? var.dbserver_login : "") == 0 ? 1 : 0
  length           = 24
  special          = true
  override_special = "%@!"
}
resource "random_password" "sql_password" {
  count            = length(var.dbserver_pwd != null ? var.dbserver_pwd : "") == 0 ? 1 : 0
  length           = 16
  special          = true
  override_special = "_%@!"
}
data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
# data azurerm_key_vault_secret sql_user {
#   name="${local.name}-user"
#   key_vault_id="${data.azurerm_key_vault.kv.id}"
# }
# data azurerm_key_vault_secret sql_password {
#   name="${local.name}-password"
#   key_vault_id="${data.azurerm_key_vault.kv.id}"
# }
# data external sql_password {
#   program=[
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.sql_password.value)}"
#     "echo", "${data.azurerm_key_vault_secret.sql_password.value}"
#   ]
# }
resource "azurerm_key_vault_secret" "sql_password" {
  #count=length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  name = "${local.name}-password" #"mssql-server-password"
  #value=length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result #random_password.password[0].result
  #value=length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password.result
  # value=local.password
  value        = length(var.dbserver_pwd != null ? var.dbserver_pwd : "") > 0 ? var.dbserver_pwd : random_password.sql_password[0].result
  key_vault_id = data.azurerm_key_vault.kv.id
  #tags=merge(local.common_tags, tomap({"type"="key_vault_secret_password"}), tomap({"resource"=azurerm_mssql_server.this.name}))
  tags       = merge(var.tags, tomap({ "type" = "key_vault_secret_password" }))
  depends_on = [data.azurerm_key_vault.kv]
}
resource "azurerm_key_vault_secret" "sql_user" {
  #count=length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  name = "${local.name}-user" #"mssql-server-password"
  #value=length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.password[0].result #random_password.password[0].result
  #value=length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.password.result
  value        = length(var.dbserver_login != null ? var.dbserver_login : "") > 0 ? var.dbserver_login : random_password.sql_user[0].result
  key_vault_id = data.azurerm_key_vault.kv.id
  #tags=merge(local.common_tags, tomap({"type"="key_vault_secret_password"}), tomap({"resource"=azurerm_mssql_server.this.name}))
  tags       = merge(var.tags, tomap({ "type" = "key_vault_secret_user" }))
  depends_on = [data.azurerm_key_vault.kv]
}
module "db_connectionstring" {
  source       = "../azurerm_key_vault_secret"
  name         = "${local.name}-connectionstring"
  value        = local.connection_string
  key_vault_id = data.azurerm_key_vault.kv.id
}
# resource azurerm_key_vault_secret" "db_connectionstring" {
#   name="${local.name}-connectionstring"
#   #;Initial Catalog=${module.azurerm_mssql_database.database_name}
#   value=local.connection_string
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
locals {
  #name=length(var.name) > 0 ? var.name : "${var.resource_group_name}-dbs"
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-dbs" : "dbs")
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-dbs" : "project-${var.resource_group_name}-dbs" : "project-dbs"
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  #user=length(data.azurerm_key_vault_secret.sql_user.value) > 0 ? data.azurerm_key_vault_secret.sql_user.value : length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.user[0].result
  #password=length(data.azurerm_key_vault_secret.sql_password.value) > 0 ? data.azurerm_key_vault_secret.sql_password.value : length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result
  #password=length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : azurerm_key_vault_secret.sql_password.value

  #user=length(azurerm_key_vault_secret.sql_user.value) > 0 ? data.azurerm_key_vault_secret.sql_user.value : length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.user[0].result
  #password=length(data.azurerm_key_vault_secret.sql_password.value) > 0 ? data.azurerm_key_vault_secret.sql_password.value : length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result

  #user=length(var.dbserver_login) > 0 ? var.dbserver_login : azurerm_key_vault_secret.sql_user.value
  #password=length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : azurerm_key_vault_secret.sql_password.value

  #vault_name=length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  #vault_resource_group=length(var.vault_resource_group) > 0 ? var.vault_resource_group : length(var.resource_group_name) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"

  user     = coalesce(var.dbserver_login, azurerm_key_vault_secret.sql_user.value)
  password = coalesce(var.dbserver_pwd, azurerm_key_vault_secret.sql_password.value)

  vault_name           = coalesce(var.vault_name, "${var.resource_group_name}-kv")
  vault_resource_group = length(coalesce(var.vault_resource_group, "")) > 0 ? var.vault_resource_group : length(coalesce(var.resource_group_name, "")) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
  connection_string    = "Server=tcp:${local.name}.database.windows.net,1433;Persist Security Info=False;User ID=${local.user};Password=${local.password};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  #Server=tcp:dev-vantage-db-server.database.windows.net,1433;Initial Catalog=dev-vantage-db;Persist Security Info=False;User ID=albatross;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
}
resource "azurerm_mssql_server" "this" {
  depends_on                   = [azurerm_key_vault_secret.sql_password]
  name                         = local.name
  version                      = var.dbserver_version
  administrator_login          = local.user
  administrator_login_password = local.password #azurerm_key_vault_secret.sql_password.value #local.password
  location                     = var.location
  resource_group_name          = var.resource_group_name
  tags                         = var.tags
  #throws error that local.user already exists
  # azuread_administrator {
  #   login_username=local.user
  #   # object_id=azuread_user.database.object_id
  #   object_id=data.azurerm_client_config.current.object_id
  # } 
}
resource "azurerm_sql_firewall_rule" "azrule" {
  depends_on          = [azurerm_mssql_server.this]
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.this.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}