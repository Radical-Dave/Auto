# terraform {
#   experiments=[module_variable_optional_attrs]
# }
locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-fa"
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-app" : "app")
  #kind=length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location = coalesce(var.location, "eastus")
  ip_restriction_default = var.ip_restriction != null ? var.ip_restriction : toset([
    {
      action = "Allow"
      name   = "vnet"
      #description="Local vnet"
      priority                  = 1
      tag                       = "Default"
      virtual_network_subnet_id = var.virtual_network_subnet_id
    },
    {
      action     = "Allow"
      ip_address = "AzureCloud"
      name       = "Deny all"
      #description="Allow Azure access"
      priority = 300
      tag      = "ServiceTag"
    },
    {
      action     = "Deny"
      ip_address = "Any"
      name       = "Deny all"
      #description="Deny all access"
      priority = 2147483647
    }
  ])
}
resource "azurerm_windows_function_app" "this" {
  #depends_on=[azurerm_resource_group.resourcegroup, azurerm_app_service_plan.asp, azurerm_storage_account.sa]
  name                 = local.name
  location             = local.location
  resource_group_name  = var.resource_group_name
  service_plan_id      = var.service_plan_id
  storage_account_name = var.storage_account_name
  # storage_account_access_key=azurerm_storage_account.sa.primary_access_key
  site_config {
    always_on = false #local.site_config.always_on
    #linux_fx_version=local.site_config.linux_fx_version
    #health_check_path=local.site_config.health_check_path
    #acr_use_managed_identity_credentials=false
    http2_enabled            = true
    app_scale_limit          = 200
    elastic_instance_minimum = 1

    # dynamic "ip_restriction" {
    #   for_each=toset(var.ip_restriction != null ? var.ip_restriction : local.ip_restriction_default)
    #   content {
    #     name=ip_restriction.name != null ? ip_restriction.name : null
    #     action=ip_restriction.action != null ? ip_restriction.action : null
    #     ip_address=ip_restriction.ip_address != null ? ip_restriction.ip_address : null          
    #     service_tag=ip_restriction.service_tag != null ? ip_restriction.service_tag : null
    #     priority=ip_restriction.priority != null ? ip_restriction.priority : null
    #     #description=ip_restriction.description != null ? ip_restriction.description : null
    #     virtual_network_subnet_id=ip_restriction.virtual_network_subnet_id != null  ? ip_restriction.virtual_network_subnet_id : null
    #   }
    # }
  }
  client_certificate_mode = "Required"
  #key_vault_reference_identity_id="SystemAssigned"

  tags = var.tags
}