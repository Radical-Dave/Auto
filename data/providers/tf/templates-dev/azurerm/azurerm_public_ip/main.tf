locals {
  name              = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-pip" : "project-${var.resource_group_name}-pip" : "project-pip"
  domain_name_label = length(var.domain_name_label != null ? var.domain_name_label : "") > 0 ? var.domain_name_label : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}" : "project-${var.resource_group_name}" : ""
}
resource "azurerm_public_ip" "this" {
  allocation_method = var.allocation_method
  #availability_zone=var.availability_zone
  domain_name_label       = local.domain_name_label
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  ip_tags                 = var.ip_tags
  location                = var.location
  name                    = local.name
  resource_group_name     = var.resource_group_name
  reverse_fqdn            = var.reverse_fqdn
  sku                     = var.sku
  sku_tier                = var.sku_tier
  tags                    = var.tags
}