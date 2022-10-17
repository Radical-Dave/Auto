output "id" {
  description = "The id of the azurerm_app_service_plan provisioned"
  value       = azurerm_app_service_plan.this.id
}
# output default_site_hostname {
#   description="The default_site_hostname of the app service plan provisioned - website.azurewebsites.net"
#   value=azurerm_app_service_plan.this.default_site_hostname
# }
# output name {
#   description="The name of the azurerm_app_service_plan provisioned"
#   value=azurerm_app_service_plan.this.name
# }
# output custom_domain_verification_id {
#   description="The custom_domain_verification_id of the azurerm_app_service_plan provisioned"
#   value=azurerm_app_service_plan.this.custom_domain_verification_id
# }
output "this" {
  value = azurerm_app_service_plan.this
}