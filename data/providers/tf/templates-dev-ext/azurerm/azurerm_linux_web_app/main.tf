locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-app" : "project-${var.resource_group_name}-app" : "project-app"
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
  client_affinity_enabled = lookup(var.settings, "client_affinity_enabled", null) #var.client_affinity_enabled
  #client_certificate_enabled=var.auth_mode == "Basic" ? false : true
  #client_certificate_mode=var.auth_mode == "Basic" ? "Optional" : "Required"
  # dynamic "connection_string" {
  #   for_each=lookup(var.settings, "connection_strings", [])
  #   content {
  #     name=connection_string.value.name
  #     type=connection_string.value.type
  #     value=connection_string.value.value
  #   }
  # }
  #container_registry_use_managed_identity=lookup(var.settings.site_config, "container_registry_use_managed_identity", null)
  enabled    = lookup(var.settings, "enabled", null)
  https_only = lookup(var.settings, "https_only", null)
  location   = var.location
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
          file_system_level = lookup(var.settings.logs.application_logs, "file_system_level", null)
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
  service_plan_id     = var.service_plan_id
  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []
    content {
      always_on = lookup(var.settings.site_config, "always_on", "true")
      dynamic "application_stack" {
        for_each = { for x in try(lookup(var.settings.site_config, "application_stack", {})) : x.docker_image_tag => "dev" }
        content {
          docker_image     = lookup(application_stack, "docker_image", null)
          docker_image_tag = lookup(application_stack, "docker_image_tag", "latest")
        }
      }
      app_command_line = lookup(var.settings.site_config, "app_command_line", null)
      dynamic "cors" {
        for_each = try(var.settings.site_config.cors, {})
        content {
          allowed_origins     = lookup(cors, "allowed_origins", null)
          support_credentials = lookup(cors, "support_credentials", null)
        }
      }
      default_documents = lookup(try(var.settings.site_config, null), "default_documents", tolist([]))
      #dotnet_framework_version=lookup(var.settings.site_config, "dotnet_framework_version", null)      
      ftps_state        = lookup(var.settings.site_config, "ftps_state", "Disabled")
      health_check_path = lookup(var.settings.site_config, "health_check_path", null)
      http2_enabled     = lookup(var.settings.site_config, "http2_enabled", false)
      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})
        content {
          ip_address                = lookup(ip_restriction, "ip_address", null)
          virtual_network_subnet_id = lookup(ip_restriction, "virtual_network_subnet_id", null)
        }
      }
      #java_version=lookup(var.settings.site_config, "java_version", null)
      #java_container=lookup(var.settings.site_config, "java_container", null)
      #java_container_version=lookup(var.settings.site_config, "java_container_version", null)
      linux_fx_version      = lookup(var.settings.site_config, "linux_fx_version", null)
      local_mysql_enabled   = lookup(var.settings.site_config, "local_mysql_enabled", null)
      managed_pipeline_mode = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      #min_tls_version=lookup(var.settings.site_config, "min_tls_version", "1.2")
      #number_of_workers=lookup(var.settings.site_config, "number_of_workers", 3)      
      #php_version=lookup(var.settings.site_config, "php_version", null)
      #python_version=lookup(var.settings.site_config, "python_version", null)
      remote_debugging_enabled = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      remote_debugging_version = lookup(var.settings.site_config, "remote_debugging_version", null)
      scm_type                 = lookup(var.settings.site_config, "scm_type", null)
      #use_32_bit_worker_process=lookup(var.settings.site_config, "use_32_bit_worker_process", false)
      websockets_enabled = lookup(var.settings.site_config, "websockets_enabled", false)
      #windows_fx_version=lookup(var.settings.site_config, "windows_fx_version", null)
    }
  }
  tags = var.tags
}
# site_config {
#   always_on=var.always_on
#   container_registry_use_managed_identity="false"
#   ftps_state="Disabled"    
#   #scm_type=local.scm_type    
#   #linux_fx_version=local.fx_version
#   health_check_path=var.health_check_path
#   #is_xenon="true"
#   # application_stack {
#   #   docker_image="${var.acr_login_server}/estserver"
#   #   docker_image_tag="latest"
#   # }
#   #scm_type=local.site_config.scm_type
#   #always_on=local.site_config.always_on
#   #linux_fx_version="DOCKER|${var.docker_registry}/${var.docker_image}:latest" #local.site_config.linux_fx_version
#   #health_check_path=local.site_config.health_check_path
#   #acr_use_managed_identity_credentials=false
#   http2_enabled=true
#   worker_count=3
#   application_stack {
#     docker_image="${var.docker_registry}/${var.docker_image}"
#     docker_image_tag="latest"
#   }
#   # dynamic "ip_restriction" {
#   #   for_each=local.ip_restriction
#   #   content {
#   #     name=ip_restriction.name != null ? ip_restriction.name : null
#   #     action=ip_restriction.action != null ? ip_restriction.action : null
#   #     ip_address=ip_restriction.ip_address != null ? ip_restriction.ip_address : null          
#   #     service_tag=ip_restriction.service_tag != null ? ip_restriction.service_tag : null
#   #     priority=ip_restriction.priority != null ? ip_restriction.priority : null
#   #     #description=ip_restriction.description != null ? ip_restriction.description : null
#   #     #virtual_network_subnet_id=ip_restriction.virtual_network_subnet_id != null  ? ip_restriction.virtual_network_subnet_id : null
#   #   }
#   # }
# }
