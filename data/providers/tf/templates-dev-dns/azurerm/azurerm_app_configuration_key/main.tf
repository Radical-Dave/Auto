locals {
  name = replace(replace(length(var.name) > 0 ? (length(var.name) > 50 ? substr(var.name, 0, 50) : var.name) : "${var.resource_group_name}-ac", " ", ""), "-", "appconfiguration")
}
resource "azurerm_app_configuration_key" "this" {
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = "appConfKey1"
  label                  = "somelabel"
  value                  = "a test"

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge({ "Name" = format("%s", local.name) }, var.tags, )
}