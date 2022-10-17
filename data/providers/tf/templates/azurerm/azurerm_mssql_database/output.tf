output "id" {
  description = "The id of the db provisioned"
  value       = azurerm_mssql_database.this.id
}
output "name" {
  description = "The name of the db provisioned"
  value       = azurerm_mssql_database.this.name
}
# output principal_id {
#   description="The principal_id of the dbserver provisioned"
#   value=azurerm_mssql_server.this.identity.0.principal_id
# }
output "connection_string" {
  description = "The connection_string of the db provisioned"
  value       = local.connection_string
}
output "connection_string_key" {
  description = "The connection_string of the db provisioned"
  value       = azurerm_key_vault_secret.db_connectionstring.id
}