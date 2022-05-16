terraform {
  experiments = [module_variable_optional_attrs]
}
locals {
  name = replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0,63) : var.name) : "${var.resource_group_name}-acr", " ", ""), "-", "")
}
resource "azurerm_container_registry_webhook" "this" {
  name = local.name
  location = var.location
  registry_name = var.registry_name
  resource_group_name = var.resource_group_name
  service_url = var.service_url
  status = var.status
  actions = var.actions
  custom_headers = var.custom_headers
  #tags = merge({ "Name" = format("%s", var.container_registry_config.name) }, var.tags, )
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, )    
}