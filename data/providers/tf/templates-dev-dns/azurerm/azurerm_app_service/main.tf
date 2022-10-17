locals {
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-app" : "app")
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}-app" : "project-${var.resource_group_name}-app": "project-app"
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : "${var.prefix}-${var.envname}"
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-app" : "project-${var.resource_group_name}-app" : "project-app"
  kind     = length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  site_config = length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
    acr_use_managed_identity_credentials = "false"
    scm_type                             = "None"
    always_on                            = "true"
    linux_fx_version                     = "DOCKER|${var.docker_registry}/${var.docker_image}:latest"
    #health_check_path="/health"
    #is_xenon="true"
    #startupcommand="az webapp config appsettings set --resource-group ${var.resource_group_name} --name ${local.name} --settings WEBSITE_PULL_IMAGE_OVER_VNET=true"
    #az webapp config container set --name <app-name> --resource-group <group-name> --docker-custom-image-name <image-name> --docker-registry-server-url <private-repo-url> --docker-registry-server-user <username> --docker-registry-server-password <password>
    #az webapp config container set --name ${local.name} --resource-group ${var.resource_group_name} --docker-custom-image-name ${var.docker_image} --docker-registry-server-url ${var.docker_registry} --docker-registry-server-user ${var.docker_username} --docker-registry-server-password ${var.docker_password}
    # application_stack {
    #   docker_container_name = "${var.docker_registry}/${var.docker_image}"
    #   docker_image_tag  = "latest"
    # }
  }
  scm_type               = length(var.scm_type != null ? var.scm_type : "") > 0 ? var.scm_type : "None"
  always_on              = length(var.always_on != null ? var.always_on : "") > 0 ? var.always_on : "true"
  fx_version             = length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:latest" : null
  health_check_path      = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : "/health"
  connection_strings     = length(var.connection_strings != null ? var.connection_strings : []) > 0 ? var.connection_strings : []
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
  #lifecycle {ignore_changes=[app_settings, site_config]}
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
  client_affinity_enabled = var.client_affinity_enabled
  client_cert_enabled     = var.client_cert_enabled
  name                    = local.name
  location                = local.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.service_plan_id
  app_settings            = var.app_settings
  https_only              = var.https_only
  #identity {type = "SystemAssigned"}
  # identity {
  #  type="SystemAssigned, UserAssigned"
  #  #identity_ids=[data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
  #  identity_ids=[data.azurerm_client_config.current.object_id]   
  # }  
  # site_config=var.site_config
  # dynamic "site_config" {
  #   for_each=local.site_config != null ? [true] : []
  #   content {
  #     #scm_type=local.site_config.scm_type
  #     always_on=local.site_config.always_on
  #     linux_fx_version=local.site_config.linux_fx_version
  #     health_check_path=local.site_config.health_check_path
  #     acr_use_managed_identity_credentials=false
  #     http2_enabled=true      
  #   }
  # }
  # logs {
  #   application_logs {
  #     azure_blob_storage {
  #       #Error,Warning,Information,Verbose,Off
  #       level="Error"
  #       retention_in_days=7
  #       sas_url=var.log_sas_url        
  #     }
  #     file_system_level="Error"
  #   }
  # }
  site_config {
    #scm_type=local.site_config.scm_type
    #always_on=local.site_config.always_on
    #linux_fx_version=local.site_config.linux_fx_version
    #health_check_path=local.site_config.health_check_path
    acr_use_managed_identity_credentials = false
    always_on                            = local.always_on
    ftps_state                           = "Disabled"
    health_check_path                    = local.health_check_path
    http2_enabled                        = true
    number_of_workers                    = 3
    scm_type                             = "None"
    #windows_fx_version=local.windows_fx_version
    linux_fx_version       = local.fx_version
    vnet_route_all_enabled = false
    # application_stack {
    #   docker_container_name="${var.docker_registry}/${var.docker_image}"
    #   docker_image_tag="latest"
    # }

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

    dynamic "cors" {
      for_each = var.cors_origins != null ? [true] : []
      content {
        allowed_origins     = var.cors_origins
        support_credentials = true
      }
    }
  }
  dynamic "connection_string" {
    for_each = local.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  tags = var.tags
  #lifecycle {ignore_changes = [app_settings,]}
}