terraform {
  #experiments=[module_variable_optional_attrs]
}
locals {
  name = replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0, 63) : var.name) : "${var.resource_group_name}-acr", " ", ""), "-", "")
  #resource_group_name=length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : var.resource_group_name
}
resource "azurerm_container_registry" "this" {
  name                          = local.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku                           #var.container_registry.sku
  admin_enabled                 = var.admin_enabled                 #var.container_registry_config.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled #var.container_registry_config.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled     #var.container_registry_config.quarantine_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled       #var.container_registry_config.zone_redundancy_enabled

  #georeplications=var.georeplications
  #network_rule_set
  #quarantine_policy_enabled
  #retention_policy
  #trust_polizy
  #zone_redundancy_enabled
  #export_policy_enabled
  #identity
  #encryption
  #anonymous_pull_enabled
  #data_endpoint_enabled

  #tags=merge({ "Name"=format("%s", var.container_registry_config.name) }, var.tags, )
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, )
}
resource "azurerm_container_registry_scope_map" "this" {
  for_each                = var.scope_map != null ? { for k, v in var.scope_map : k => v if v != null } : {}
  name                    = format("%s", each.key)
  resource_group_name     = var.resource_group_name
  container_registry_name = local.name
  actions                 = each.value["actions"]
}
resource "azurerm_container_registry_token" "this" {
  for_each                = var.scope_map != null ? { for k, v in var.scope_map : k => v if v != null } : {}
  name                    = format("%s", "${each.key}-token")
  resource_group_name     = var.resource_group_name
  container_registry_name = local.name
  scope_map_id            = element([for k in azurerm_container_registry_scope_map.this : k.id], 0)
  enabled                 = true
}
resource "azurerm_container_registry_webhook" "this" {
  for_each            = var.container_registry_webhooks != null ? { for k, v in var.container_registry_webhooks : k => v if v != null } : {}
  name                = format("%s", each.key)
  registry_name       = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_uri         = each.value["service_uri"]
  actions             = each.value["actions"]
  status              = each.value["status"]
  scope               = each.value["scope"]
  custom_headers      = each.value["custom_headers"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}