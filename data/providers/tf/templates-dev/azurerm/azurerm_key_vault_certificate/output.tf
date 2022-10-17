output "id" {
  description = "The id of the azurerm_key_vault_certificate provisioned"
  value       = azurerm_key_vault_certificate.this.id
}
output "secret_id" {
  description = "The secret_id of the azurerm_key_vault_certificate provisioned"
  value       = azurerm_key_vault_certificate.this.secret_id
}
output "thumbprint" {
  description = "The thumbprint of the azurerm_key_vault_certificate provisioned"
  value       = azurerm_key_vault_certificate.this.thumbprint
}