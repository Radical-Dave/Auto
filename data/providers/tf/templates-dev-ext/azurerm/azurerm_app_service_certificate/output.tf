output "id" {
  description = "The id of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.id
}
output "expiration_date" {
  description = "The expiration_date of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.expiration_date
}
output "friendly_name" {
  description = "The friendly_name of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.friendly_name
}
output "host_names" {
  description = "The host_names of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.host_names
}
output "issue_date" {
  description = "The issue_date of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.issue_date
}
output "issuer" {
  description = "The issuer of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.issuer
}
output "subject_name" {
  description = "The subject_name of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.subject_name
}
output "thumbprint" {
  description = "The thumbprint of the azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this.thumbprint
}
output "this" {
  description = "The azurerm_app_service_certificate provisioned"
  value       = azurerm_app_service_certificate.this
}