output "id" {
  description = "The id of the resource group provisioned"
  value = "${azurerm_key_vault_key.this.id}"
}
output "vault_uri" {
  value = azurerm_key_vault_key.this.*.vault_uri
}