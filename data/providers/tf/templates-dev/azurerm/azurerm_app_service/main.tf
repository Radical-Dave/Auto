locals {
  connection_strings     = length(var.connection_strings != null ? var.connection_strings : []) > 0 ? var.connection_strings : []
  fx_version             = length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:${var.docker_image_tag}" : null
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
  app_service_plan_id = var.service_plan_id
  app_settings        = var.app_settings
  #client_affinity_enabled=var.client_affinity_enabled
  #client_cert_enabled=var.client_cert_enabled
  #client_cert_mode=var.client_cert_mode
  dynamic "connection_string" {
    for_each = local.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  https_only = var.https_only
  #identity {type = "SystemAssigned"}
  # identity {
  #  type="SystemAssigned, UserAssigned"
  #  #identity_ids=[data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
  #  identity_ids=[data.azurerm_client_config.current.object_id]   
  # }  
  location = var.location
  logs {
    application_logs {
      azure_blob_storage {
        #Error,Warning,Information,Verbose,Off
        level             = "Warning"
        retention_in_days = 7
        sas_url           = var.log_sas_url
      }
      file_system_level = "Warning"
    }
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }
  name                = local.name
  resource_group_name = var.resource_group_name
  site_config {
    acr_use_managed_identity_credentials = false
    always_on                            = var.always_on
    dynamic "cors" {
      for_each = var.cors_origins != null ? [true] : []
      content {
        allowed_origins     = var.cors_origins
        support_credentials = true
      }
    }
    ftps_state        = "Disabled"
    health_check_path = local.health_check_path
    http2_enabled     = true
    # dynamic "ip_restriction" {
    #   for_each=local.ip_restriction
    #   content {
    #     #action=ip_restriction.action != null ? ip_restriction.action : null
    #     #description=ip_restriction.description != null ? ip_restriction.description : null
    #     #ip_address=ip_restriction.value.ip_address != null ? ip_restriction.value.ip_address : null
    #     #name=ip_restriction.name != null ? ip_restriction.name : null
    #     #priority=ip_restriction.priority != null ? ip_restriction.priority : null
    #     #service_tag=ip_restriction.service_tag != null ? ip_restriction.service_tag : null
    #     virtual_network_subnet_id=ip_restriction.value.virtual_network_subnet_id != null ? ip_restriction.value.virtual_network_subnet_id : null
    #   }
    # }
    number_of_workers = 3
    #scm_type="None"
    #linux_fx_version=local.fx_version
    vnet_route_all_enabled = false
    windows_fx_version     = local.fx_version
  }
  tags = var.tags
}