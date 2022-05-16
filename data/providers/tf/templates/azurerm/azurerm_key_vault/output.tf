output "id" {
  description = "The id of the resource group provisioned"
  value = "${azurerm_key_vault.this.id}"
}
output "vault_uri" {
  value = azurerm_key_vault.this.*.vault_uri
}