terraform {
  #experiments=[module_variable_optional_attrs]
}
locals {
  connection_strings = length(var.connection_strings != null ? var.connection_strings : []) > 0 ? var.connection_strings : []
  name               = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-app" : "project-${var.resource_group_name}-app" : "project-app"
  # site_config=length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
  #   scm_type=length(var.scm_type != null ? var.scm_type : "") > 0 ? var.scm_type : "None"
  #   always_on=length(var.always_on != null ? var.always_on : "") > 0 ? var.always_on : "true"
  #   linux_fx_version=length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:latest" : null
  #   health_check_path=length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : "/health"
  # }
  #fx_version=length(var.linux_fx_version != null ? var.linux_fx_version : "") > 0 ? var.linux_fx_version : length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:latest" : null
  #health_check_path=length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : "/health"
  ip_restriction_default = [
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
      name       = "azure"
      #description="Allow Azure access"
      priority = 300
      tag      = "ServiceTag"
    },
    # {
    #   action="Deny"
    #   ip_address="Any"
    #   name="Deny all"
    #   #description="Deny all access"
    #   priority=2147483647
    # }
  ]
  ip_restriction = var.ip_restriction != null ? var.ip_restriction : tomap(local.ip_restriction_default)
  #ip_restriction=var.ip_restriction != null ? var.ip_restriction : { for item in local.ip_restriction_default: item.key => item.value }  
}
resource "azurerm_linux_web_app" "this" {
  app_settings            = var.app_settings
  client_affinity_enabled = var.client_affinity_enabled
  #client_certificate_enabled=var.auth_mode == "Basic" ? false : true
  #client_certificate_mode=var.auth_mode == "Basic" ? "Optional" : "Required"
  dynamic "connection_string" {
    for_each = local.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  https_only = var.https_only
  location   = var.location
  # logs {
  #   application_logs {
  #     azure_blob_storage {
  #       #Error,Warning,Information,Verbose,Off
  #       level="Warning"
  #       retention_in_days=7
  #       sas_url=replace(var.log_sas_url,".windows.net/",".windows.net/logs")
  #     }
  #     file_system_level="Warning"
  #   }
  #   http_logs {
  #     file_system {
  #       retention_in_days=7
  #       retention_in_mb=35
  #     }
  #   }
  # }
  name                = local.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  # site_config=var.site_config
  site_config {
    always_on                               = var.always_on
    container_registry_use_managed_identity = "false"
    dynamic "cors" {
      for_each = var.cors_origins != null ? [true] : []
      content {
        allowed_origins     = var.cors_origins
        support_credentials = true
      }
    }
    ftps_state        = "Disabled"
    health_check_path = var.health_check_path
    application_stack {
      docker_image     = "${var.docker_registry}/${var.docker_image}"
      docker_image_tag = var.docker_image_tag
    }
    http2_enabled = true
    worker_count  = 3
    # dynamic "ip_restriction" {
    #   for_each=local.ip_restriction
    #   content {
    #     name=ip_restriction.name != null ? ip_restriction.name : null
    #     action=ip_restriction.action != null ? ip_restriction.action : null
    #     ip_address=ip_restriction.ip_address != null ? ip_restriction.ip_address : null          
    #     service_tag=ip_restriction.service_tag != null ? ip_restriction.service_tag : null
    #     priority=ip_restriction.priority != null ? ip_restriction.priority : null
    #     #description=ip_restriction.description != null ? ip_restriction.description : null
    #     #virtual_network_subnet_id=ip_restriction.virtual_network_subnet_id != null  ? ip_restriction.virtual_network_subnet_id : null
    #   }
    # }
  }
  tags = var.tags
}