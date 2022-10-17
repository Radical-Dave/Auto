output "id" {
  description = "The id of the azuread_application_federated_identity_credential provisioned"
  value       = azuread_application_federated_identity_credential.this.id
}
output "credential_id" {
  description = "The credential_id of the azuread_application_federated_identity_credential provisioned"
  value       = azuread_application_federated_identity_credential.this.credential_id
}