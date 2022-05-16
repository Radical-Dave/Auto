output "id" {
  description = "The id of the dbserver provisioned"
  value = "${azurerm_mssql_server.this.id}"
}
output "name" {
  description = "The name of the dbserver provisioned"
  value = "${azurerm_mssql_server.this.name}"
}
# output "principal_id" {
#   description = "The principal_id of the dbserver provisioned"
#   value = "${azurerm_mssql_server.this.identity.0.principal_id}"
# }