locals {
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-pip" : "pip")
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-pip" : "project-${var.resource_group_name}-pip" : "project-pip"
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  #domain_name_label=length(var.domain_name_label) > 0 ? (length(var.domain_name_label) > 64 ? substr(var.domain_name_label,0,63) : var.domain_name_label) : length(var.resource_group_name) > 64 ? substr(var.resource_group_name,0,63) : "${var.resource_group_name}"
  #domain_name_label=length(var.domain_name_label != null ? var.domain_name_label : "") > 0 ? (length(var.domain_name_label !=null ? var.domain_name_label : "") > 64 ? substr(var.domain_name_label,0,63) : var.domain_name_label) : (length(var.resource_group_name != null ? (var.resource_group_name : "") > 0 ? (length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}" : "project-${var.resource_group_name}-pip")))))))
  domain_name_label = length(var.domain_name_label != null ? var.domain_name_label : "") > 0 ? var.domain_name_label : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}" : "project-${var.resource_group_name}" : ""
  #length(var.resource_group_name) > 64 ? substr(var.resource_group_name,0,63) : "${var.resource_group_name}"
}
resource "azurerm_public_ip" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  sku_tier            = var.sku_tier
  #availability_zone=var.availability_zone
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = local.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  ip_tags                 = var.ip_tags
  tags                    = var.tags
}