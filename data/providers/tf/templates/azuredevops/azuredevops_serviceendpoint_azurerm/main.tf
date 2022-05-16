data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}
locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
  description = length(var.description != null ? var.description : "") > 0 ? var.description : length(local.name != null ? local.name : "") > 0 ? local.name : ""
}
resource "azuredevops_serviceendpoint_azurerm" "this" {
  azurerm_spn_tenantid = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
  description = var.description
  project_id = var.project_id
  service_endpoint_name = local.name
  credentials {
    serviceprincipalid = var.service_principal_id
    serviceprincipalkey = var.service_prinicpal_key
  }
  # credentials {
  #   serviceprincipalid = azuread_application.service_connection.application_id
  #   serviceprincipalkey = random_password.service_connection.result
  # }
  #location  = var.location
  #tags      = var.tags  
}