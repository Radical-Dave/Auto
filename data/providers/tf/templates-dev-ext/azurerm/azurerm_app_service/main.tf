locals {
  health_check_path      = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : "/health"
  ip_restriction_default = []
  #   {
  #     #action="Allow"
  #     #description="Local vnet"
  #     #name="vnet"      
  #     #priority=1
  #     #service_tag="Default"
  #     virtual_network_subnet_id=var.virtual_network_subnet_id
  #   },
  #   #{
  #     #action="Allow"
  #     #description="Allow Azure access"
  #     #ip_address="AzureCloud"
  #     #name="azure"      
  #     #priority=300
  #     #service_tag="ServiceTag"
  #   #  virtual_network_subnet_id=var.virtual_network_subnet_id
  #   #},
  #   # {
  #   #   action="Deny"
  #   #   ip_address="Any"
  #   #   name="Deny all"
  #   #   #description="Deny all access"
  #   #   priority=2147483647
  #   # }
  # ]
  ip_restriction = var.ip_restriction != null ? var.ip_restriction : local.ip_restriction_default
  name           = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-app" : "project-${var.resource_group_name}-app" : "project-app"
}
#manged identities
# data azurerm_user_assigned_identity assigned_identity_acr_pull {
#  provider=azurerm.acr_sub
#  name=length(var.docker_username != null ? var.docker_username : "") > 0 ? var.docker_username : "azdevops"
#  resource_group_name=var.dns_resource_group_name
# }
# data azurerm_user_assigned_identity assigned_identity_acr_pull {
#  provider=azurerm.acr_sub
#  name=var.docker_username
#  resource_group_name=var.resource_group_name
# }
# data azurerm_user_assigned_identity assigned_identity_acr_pull {
#  provider=azurerm.acr_sub
#  name=var.docker_username
#  resource_group_name=var.resource_group_name
# }

# data azurerm_container_registry acr {
#   name=var.docker_registry
#   resource_group_name=var.resource_group_name
# }
#data azurerm_client_config current {}
resource "azurerm_app_service" "this" {
  app_service_plan_id     = var.service_plan_id
  app_settings            = var.app_settings
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  # dynamic "cors" {
  #   for_each=var.cors_origins != null ? [true] : []
  #   content {
  #     allowed_origins=var.cors_origins
  #     support_credentials=true
  #   }
  # }
  https_only = var.https_only
  #identity {type = "SystemAssigned"}
  # identity {
  #  type="SystemAssigned, UserAssigned"
  #  #identity_ids=[data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
  #  identity_ids=[data.azurerm_client_config.current.object_id]   
  # }  
  location = var.location
  # logs {
  #   application_logs {
  #     azure_blob_storage {
  #       #Error,Warning,Information,Verbose,Off
  #       level="Warning"
  #       retention_in_days=7
  #       sas_url=var.log_sas_url        
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
  dynamic "logs" {
    for_each = lookup(var.settings, "logs", {}) != {} ? [1] : []
    content {
      dynamic "application_logs" {
        for_each = lookup(var.settings.logs, "application_logs", {}) != {} ? [1] : []
        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.application_logs, "azure_blob_storage", {}) != {} ? [1] : []
            content {
              level             = var.settings.logs.application_logs.azure_blob_storage.level
              sas_url           = var.settings.logs.application_logs.azure_blob_storage.sas_url
              retention_in_days = var.settings.logs.application_logs.azure_blob_storage.retention_in_days
            }
          }
        }
      }
      dynamic "http_logs" {
        for_each = lookup(var.settings.logs, "http_logs", {}) != {} ? [1] : []
        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.http_logs, "azure_blob_storage", {}) != {} ? [1] : []
            content {
              sas_url           = var.settings.logs.http_logs.azure_blob_storage.sas_url
              retention_in_days = var.settings.logs.http_logs.azure_blob_storage.retention_in_days
            }
          }
          dynamic "file_system" {
            for_each = lookup(var.settings.logs.http_logs, "file_system", {}) != {} ? [1] : []
            content {
              retention_in_days = var.settings.logs.http_logs.file_system.retention_in_days
              retention_in_mb   = var.settings.logs.http_logs.file_system.retention_in_mb
            }
          }
        }
      }
    }
  }
  name                = local.name
  resource_group_name = var.resource_group_name
  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []
    content {
      always_on        = lookup(var.settings.site_config, "always_on", true)
      app_command_line = lookup(var.settings.site_config, "app_command_line", null)
      dynamic "cors" {
        for_each = try(var.settings.site_config.cors, {})
        content {
          allowed_origins     = lookup(cors, "allowed_origins", null)
          support_credentials = lookup(cors, "support_credentials", null)
        }
      }
      #default_documents=lookup(try(var.settings.site_config,null), "default_documents", tolist([]))
      dotnet_framework_version = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state               = lookup(var.settings.site_config, "ftps_state", "Disabled")
      health_check_path        = lookup(var.settings.site_config, "health_check_path", local.health_check_path)
      http2_enabled            = lookup(var.settings.site_config, "http2_enabled", false)
      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})
        content {
          ip_address                = lookup(ip_restriction, "ip_address", null)
          virtual_network_subnet_id = lookup(ip_restriction, "virtual_network_subnet_id", null)
        }
      }
      java_version              = lookup(var.settings.site_config, "java_version", null)
      java_container            = lookup(var.settings.site_config, "java_container", null)
      java_container_version    = lookup(var.settings.site_config, "java_container_version", null)
      linux_fx_version          = lookup(var.settings.site_config, "linux_fx_version", null)
      local_mysql_enabled       = lookup(var.settings.site_config, "local_mysql_enabled", null)
      managed_pipeline_mode     = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      min_tls_version           = lookup(var.settings.site_config, "min_tls_version", "1.2")
      number_of_workers         = lookup(var.settings.site_config, "number_of_workers", 3)
      php_version               = lookup(var.settings.site_config, "php_version", null)
      python_version            = lookup(var.settings.site_config, "python_version", null)
      remote_debugging_enabled  = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      remote_debugging_version  = lookup(var.settings.site_config, "remote_debugging_version", null)
      scm_type                  = lookup(var.settings.site_config, "scm_type", null)
      use_32_bit_worker_process = lookup(var.settings.site_config, "use_32_bit_worker_process", false)
      websockets_enabled        = lookup(var.settings.site_config, "websockets_enabled", false)
      windows_fx_version        = lookup(var.settings.site_config, "windows_fx_version", null)
    }
  }
  tags = var.tags
}