locals {
  hostname = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}.${var.resource_group_name}" : "${var.resource_group_name}"
  #name = coalesce(var.name, "asuid.${local.hostname}")  
  #name = coalesce(var.name, "${local.hostname}")  
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "${length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}." : ""}${var.resource_group_name != "dev-peregrine" ? var.resource_group_name : "dev"}"
  #record = length(var.record != null ? var.record : "") > 0 ? var.record : length(var.prefix != null ? var.prefix : "") > 0 ? var.prefix != var.name ? var.prefix : "${var.prefix}.${var.resource_group_name}" : local.name
  #record = prefix.resourcegroup.azurewebsites.net
  #record = length(var.record != null ? var.record : "") > 0 ? var.record : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : ""  
  #record = length(var.target_resource_id != null ? var.target_resource_id : "") > 0 ? "" : length(var.record != null ? var.record : "") > 0 ? var.record : length(var.prefix != null ? var.prefix : "") > 0 ? var.prefix != var.name ? "${var.prefix}.${var.resource_group_name}" : var.resource_group_name : var.resource_group_name
  #record = "${var.prefix != var.name && var.prefix != "dev" ? "${var.prefix}." : ""}${var.resource_group_name}.azurewebsites.net"
  record = length(var.target_resource_id != null ? var.target_resource_id : "") > 0 ? null : length(var.record != null ? var.record : "") > 0 ? var.record : length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}.${var.resource_group_name}" : var.resource_group_name
  defaultdomain = length(var.defaultdomain != null ? var.defaultdomain: "") > 0 ? length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}.${var.resource_group_name}.azurewebsites.net" : "${var.resource_group_name}.azurewebsites.net" : "${var.resource_group_name}.azurewebsites.net"
}
resource "azurerm_dns_cname_record" "this" {
  name = local.name
  ttl = var.ttl
  zone_name = var.zone_name
  resource_group_name = var.dns_resource_group_name
  tags = var.tags
  #record = "${var.prefix != var.name && var.prefix != "dev" ? "${var.prefix}." : ""}${var.resource_group_name}.azurewebsites.net"
  record = local.record
  target_resource_id = var.target_resource_id
}