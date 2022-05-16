resource "random_password" "sql_user" {
  count = length(var.dbserver_login) == 0 ? 1 : 0
  length = 24
  special = true
  override_special = "%@!"
}
resource "random_password" "sql_password" {
  count = length(var.dbserver_pwd) == 0 ? 1 : 0
  length = 16
  special = true
  override_special = "_%@!"
}
data "azurerm_key_vault" "key_vault" {
  name = local.vault_name
  resource_group_name = local.vault_resource_group
}
# data "azurerm_key_vault_secret" "sql_user" {
#   name = "${local.name}-user"
#   key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
# }
# data "azurerm_key_vault_secret" "sql_password" {
#   name = "${local.name}-password"
#   key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
# }
# data "external" "sql_password" {
#   program = [
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.sql_password.value)}"
#     "echo", "${data.azurerm_key_vault_secret.sql_password.value}"
#   ]
# }
resource "azurerm_key_vault_secret" "sql_password" {
  #count = length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  name = "${local.name}-password" #"mssql-server-password"
  #value = length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result #random_password.password[0].result
  #value = length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password.result
  # value = local.password
  value = length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.sql_password[0].result
  key_vault_id = data.azurerm_key_vault.key_vault.id
  #tags = merge(local.common_tags, tomap({"type" = "key_vault_secret_password"}), tomap({"resource" = azurerm_mssql_server.this.name}))
  tags = merge(var.tags, tomap({"type" = "key_vault_secret_password"}))
  depends_on = [data.azurerm_key_vault.key_vault]
}
resource "azurerm_key_vault_secret" "sql_user" {
  #count = length(data.azurerm_key_vault_secret.sql_password.value) == 0 ? 1 : 0
  name = "${local.name}-user" #"mssql-server-password"
  #value = length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.password[0].result #random_password.password[0].result
  #value = length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.password.result
  value = length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.sql_user[0].result
  key_vault_id = data.azurerm_key_vault.key_vault.id
  #tags = merge(local.common_tags, tomap({"type" = "key_vault_secret_password"}), tomap({"resource" = azurerm_mssql_server.this.name}))
  tags = merge(var.tags, tomap({"type" = "key_vault_secret_user"}))
  depends_on = [data.azurerm_key_vault.key_vault]
}
locals {
  #name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-dbs"
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-dbs" : "dbs")
  location = coalesce(var.location, "eastus")
  #user = length(data.azurerm_key_vault_secret.sql_user.value) > 0 ? data.azurerm_key_vault_secret.sql_user.value : length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.user[0].result
  #password = length(data.azurerm_key_vault_secret.sql_password.value) > 0 ? data.azurerm_key_vault_secret.sql_password.value : length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result
  #password = length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : azurerm_key_vault_secret.sql_password.value

  #user = length(azurerm_key_vault_secret.sql_user.value) > 0 ? data.azurerm_key_vault_secret.sql_user.value : length(var.dbserver_login) > 0 ? var.dbserver_login : random_password.user[0].result
  #password = length(data.azurerm_key_vault_secret.sql_password.value) > 0 ? data.azurerm_key_vault_secret.sql_password.value : length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : random_password.password[0].result

  #user = length(var.dbserver_login) > 0 ? var.dbserver_login : azurerm_key_vault_secret.sql_user.value
  #password = length(var.dbserver_pwd) > 0 ? var.dbserver_pwd : azurerm_key_vault_secret.sql_password.value

  #vault_name = length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  #vault_resource_group = length(var.vault_resource_group) > 0 ? var.vault_resource_group : length(var.resource_group_name) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"

  user = coalesce(var.dbserver_login, azurerm_key_vault_secret.sql_user.value)
  password = coalesce(var.dbserver_pwd, azurerm_key_vault_secret.sql_password.value)

  vault_name = coalesce(var.vault_name, "${var.resource_group_name}-kv")
  vault_resource_group = length(coalesce(var.vault_resource_group,""))>0 ? var.vault_resource_group : length(coalesce(var.resource_group_name,"")) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"

}
resource "azurerm_mssql_server" "this" {
  depends_on = [azurerm_key_vault_secret.sql_password]
  name = local.name
  version = var.dbserver_version
  administrator_login = local.user
  administrator_login_password = local.password #azurerm_key_vault_secret.sql_password.value #local.password
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags  
}