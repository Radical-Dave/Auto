output "app_id" {
  description = "The id of the app service provisioned"
  value       = module.azurerm_app.id
}
# output app_default_site_hostname {
#   description="The default_site_hostname of the app service provisioned - website.azurewebsites.net"
#   value=module.azurerm_app.default_site_hostname
# }
output "app_name" {
  description = "The name of the app service provisioned"
  value       = module.azurerm_app.name
}
output "app_custom_domain_verification_id" {
  description = "The custom_domain_verification_id of the app service provisioned"
  value       = module.azurerm_app.custom_domain_verification_id
}
output "app" {
  value = module.azurerm_app
}