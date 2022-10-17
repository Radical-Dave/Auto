locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-app" : "app"
  site_config = length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
    scm_type          = "None"
    always_on         = "true"
    linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_image}:latest"
    health_check_path = "/health"
  }
}
# data azurerm_user_assigned_identity assigned_identity_acr_pull {
#  provider=azurerm.acr_sub
#  name=length(var.docker_username != null ? var.docker_username : "") > 0 ? var.docker_username : "azdevops"
#  resource_group_name=var.dns_resource_group_name
# }
resource "azurerm_app_service_slot" "this" {
  app_service_name        = var.app_service_name
  app_service_plan_id     = var.service_plan_id
  app_settings            = var.app_settings
  client_affinity_enabled = var.client_affinity_enabled
  https_only              = var.https_only
  # identity {
  #  type="SystemAssigned, UserAssigned"
  #  identity_ids=[data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
  # }  
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
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
  site_config {
    #scm_type=local.site_config.scm_type
    #always_on=local.site_config.always_on
    #linux_fx_version=local.site_config.linux_fx_version
    #health_check_path=local.site_config.health_check_path
    acr_use_managed_identity_credentials = false
    http2_enabled                        = true
  }
  tags = var.tags
}