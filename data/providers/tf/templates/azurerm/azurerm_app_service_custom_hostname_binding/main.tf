locals {
  app_service_name = coalesce(var.app_service_name, "${var.resource_group_name}-asp")
  defaultdomain = var.defaultdomain != null ? var.defaultdomain : "" #coalesce(var.defaultdomain, "azurewebsites.net")
  domain = coalesce(var.domain, local.defaultdomain)
  #hostname = coalesce(var.hostname, "${var.resource_group_name}.${local.domain}")
  #hostname = length(try(var.hostname,null)) > 0 ? "xx" : length(try(var.prefix,"")) > 0 ? "${var.prefix}.${var.resource_group_name}.${local.domain}" : "${var.resource_group_name}.${local.domain}"
  hostname = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}.${var.resource_group_name}.${local.domain}" : "${var.resource_group_name}.${local.domain}"
}
resource "azurerm_app_service_custom_hostname_binding" "this" {
  app_service_name = local.app_service_name
  hostname = local.hostname
  resource_group_name = var.resource_group_name
}