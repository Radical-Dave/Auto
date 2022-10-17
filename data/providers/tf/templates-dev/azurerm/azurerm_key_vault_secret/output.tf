output "id" {
  description = "The id of the resource group provisioned"
  value       = azurerm_key_vault_secret.this.id
}
# output client_id {
#   description="The id of the resource group provisioned"
#   value=azurerm_key_vault_secret.this.object_id
# }
# output vault_uri {
#   value=azurerm_key_vault_secret.this.*.vault_uri
# }
output "value" {
  value = azurerm_key_vault_secret.this.*.value
}
output "version" {
  value = azurerm_key_vault_secret.this.*.version
}
output "versionless_id" {
  value = azurerm_key_vault_secret.this.*.versionless_id
}