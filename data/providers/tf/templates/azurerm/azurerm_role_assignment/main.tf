data "azurerm_subscription" "primary" { }
data "azurerm_client_config" "current" { }
# data "azurerm_management_group" "current" { name = "00000000-0000-0000-0000-000000000000" }

locals {  
  azuread_service_principal_id = length(var.azuread_service_principal_id) > 0 ? var.azuread_service_principal_id : data.azurerm_client_config.current.object_id
  # scope = length(var.scope) > 0 ? var.scope : data.azurerm_management_group.primary.id #data.azurerm_subscription.primary.id
  scope = length(var.scope) > 0 ? var.scope : data.azurerm_subscription.primary.id
}

resource "azurerm_role_assignment" "this" {
  count = length(var.roles)
  name = var.name
  #condition = var.condition
  #description = var.description
  #role_definition_id = var.role_definition_id
  #role_definition_name = var.role_definition_name
  scope = local.scope
  role_definition_name = var.roles[count.index]
  principal_id = local.azuread_service_principal_id
}