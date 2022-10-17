locals {
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-pip" : "pip")
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-pip" : "project-${var.resource_group_name}-pip" : "project-pip"
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  logs     = ["AzureFireWallApplicationRule", "AzureFirewallNetworkRule", "AzureFirewallDnsProxy", "AllMetrics"]
  #domain_name_label=length(var.domain_name_label) > 0 ? (length(var.domain_name_label) > 64 ? substr(var.domain_name_label,0,63) : var.domain_name_label) : length(var.resource_group_name) > 64 ? substr(var.resource_group_name,0,63) : "${var.resource_group_name}"
  #domain_name_label=length(var.domain_name_label != null ? var.domain_name_label : "") > 0 ? (length(var.domain_name_label !=null ? var.domain_name_label : "") > 64 ? substr(var.domain_name_label,0,63) : var.domain_name_label) : (length(var.resource_group_name != null ? (var.resource_group_name : "") > 0 ? (length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}" : "project-${var.resource_group_name}-pip")))))))
  domain_name_label = length(var.domain_name_label != null ? var.domain_name_label : "") > 0 ? var.domain_name_label : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}" : "project-${var.resource_group_name}" : ""
  #length(var.resource_group_name) > 64 ? substr(var.resource_group_name,0,63) : "${var.resource_group_name}"
}
resource "azurerm_monitor_diagnostic_setting" "this" {
  log_analytics_workspace_id = var.log_analytics_workspace_id
  name                       = local.name
  target_resource_id         = var.target_resource_id
  dynamic "log" {
    for_each = local.logs
    content {
      log {
        category = log.value
        enabled  = true
        returnion_policy {
          enabled = false
        }
      }
    }
    # log {
    #   category="AzureFireWallApplicationRule"
    #   enabled=true
    #   returnion_policy {
    #     enabled=false
    #   }
    # }
    # log {
    #   category="AzureFirewallNetworkRule"
    #   enabled=true
    #   retention_policy {
    #     enabled=false
    #   }
    # }

    # log {
    #   category="AzureFirewallDnsProxy"
    #   enabled=true
    #   retention_policy {
    #     enabled=false
    #   }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}