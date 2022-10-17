output "id" {
  description = "The id of the azuredevops_serviceendpoint_azurerm provisioned"
  value       = azuredevops_serviceendpoint_azurerm.this.id
}
# output "location" {
#   description = "The location of the azuredevops_serviceendpoint_azurerm provisioned"
#   value = azuredevops_serviceendpoint_azurerm.this.location
# }
output "name" {
  description = "The name of the azuredevops_serviceendpoint_azurerm provisioned"
  value       = azuredevops_serviceendpoint_azurerm.this.service_endpoint_name
}
output "project_id" {
  description = "The project_id of the azuredevops_serviceendpoint_azurerm provisioned"
  value       = azuredevops_serviceendpoint_azurerm.this.project_id
}
output "service_endpoint_name" {
  description = "The service_endpoint_name of the azuredevops_serviceendpoint_azurerm provisioned"
  value       = azuredevops_serviceendpoint_azurerm.this.service_endpoint_name
}