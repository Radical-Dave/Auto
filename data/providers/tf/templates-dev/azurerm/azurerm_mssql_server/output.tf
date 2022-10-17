output "id" {
  description = "The id of the dbserver provisioned"
  value       = azurerm_mssql_server.this.id
}
output "fully_qualified_domain_name" {
  description = "The fully_qualified_domain_name of the dbserver provisioned"
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}
output "name" {
  description = "The name of the dbserver provisioned"
  value       = azurerm_mssql_server.this.name
}
output "connection_string" {
  description = "The connection_string of the dbserver provisioned"
  value       = local.connection_string
}
output "connection_string_key" {
  description = "The connection_string of the dbserver provisioned"
  #value=azurerm_key_vault_secret.db_connectionstring.id
  value = module.db_connectionstring.id
}
output "user" {
  description = "The connection_string of the dbserver provisioned"
  value       = local.user
}
output "user_password" {
  description = "The connection_string of the dbserver provisioned"
  value       = local.password
}
# output principal_id {
#   description="The principal_id of the dbserver provisioned"
#   value=azurerm_mssql_server.this.identity.0.principal_id
# }