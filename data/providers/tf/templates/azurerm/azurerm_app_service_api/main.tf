locals {
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-api" : "api")
  kind = length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location = coalesce(var.location, "eastus")
  site_config = length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_repo != null ? var.docker_repo : "") == 0 ? {} : {
    scm_type = "ExternalGit"
    always_on = "true"
    linux_fx_version = "DOCKER|${var.docker_repo}/${var.docker_app}:latest"
    health_check_path = "/health"
  }
}
resource "azurerm_app_service" "this" {
  name = local.name
  location = local.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.service_plan_id
  app_settings = var.app_settings
  https_only = var.https_only
  client_affinity_enabled = var.client_affinity_enabled
  #site_config = var.site_config
  dynamic "site_config" {
    for_each = local.site_config != null ? [true] : []
    content {
      #scm_type = local.site_config.scm_type
      always_on = local.site_config.always_on
      linux_fx_version = local.site_config.linux_fx_version
      health_check_path = local.site_config.health_check_path
      acr_use_managed_identity_credentials = false
      http2_enabled = true
    }
  }  
  tags = var.tags
}