output "id" {
  description = "The id of the azuread_service_principal provisioned"
  value       = [azurerm_role_assignment.this.*.id]
}

output "description" {
  description = "The description of the azuread_service_principal provisioned"
  value       = [azurerm_role_assignment.this.*.description]
}