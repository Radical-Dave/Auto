locals {
  #app_settings=try(length(var.app_settings != null ? var.app_settings : "") > 0 ? var.app_settings : tomap(local.app_settings_default), {})  
  app_settings          = merge(local.app_settings_appinsights, local.app_settings_docker) #,local.app_settings_web_storage)
  app_settings_api      = merge(local.app_settings_appinsights, local.app_settings_docker, local.app_settings_website)
  app_settings_api_core = merge(local.app_settings_api, local.app_settings_project, var.app_settings_api_core)
  #app_settings_appinsights=merge(local.app_settings_appinsights_default,local.app_settings_appinsights_dynamic)
  app_settings_appinsights = {
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "disabled"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "disabled"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "default"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }
  app_settings_docker = {
    "DOCKER_ENABLE_CI" = "true"
    #"DOCKER_CUSTOM_IMAGE_NAME"="DOCKER|${var.app}"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_username
    #"WEBSITE_PULL_IMAGE_OVER_VNET":"true"
  }
  app_settings_website = {
    "ASPNETCORE_ENVIRONMENT" = length(regexall("${var.host_root}-*", local.name)) > 0 ? length(regexall(".*-qa*", local.name)) > 0 ? "Staging" : "Development" : "Production"
    "WEBSITES_PORT"          = "80"
    #"WEBSITE_HTTPLOGGING_RETENTION_DAYS"="1"
  } #,local.app_settings_web_storage)
  # app_settings_web_storage={
  #   "WEBSITES_ENABLE_APP_SERVICE_STORAGE"="false"
  #}
  name = length(var.name != null ? var.name : "") > 0 ? var.name : var.resource_group_name
}
module "azurerm_app" {
  source       = "../azurerm_app_linux"
  app_settings = local.app_settings
  #app_sp=var.app_sp
  client_affinity_enabled     = var.client_affinity_enabled
  dns_domain                  = var.dns_domain
  dns_resource_group_name     = var.dns_resource_group_name
  docker_image                = var.app
  docker_image_tag            = var.docker_image_tag
  docker_name                 = var.docker_name
  docker_password             = var.docker_password
  docker_registry             = var.docker_registry
  docker_username             = var.docker_username
  host                        = var.host
  hostname                    = var.hostname
  https_only                  = var.https_only
  location                    = var.location
  log_sas_url                 = var.log_sas_url
  name                        = "${local.name}-app"
  resource_group_name         = var.resource_group_name
  service_plan_id             = var.service_plan_id
  virtual_network_subnet_id   = var.virtual_network_subnet_id_app
  zone_name                   = var.zone_name
  #ARR_Affinity=off
}
module "azurerm_api" {
  source       = "../azurerm_app_linux"
  app_settings = var.api != "core-api" ? local.app_settings_api : local.app_settings_api_core
  #app_sp=var.app_sp
  client_affinity_enabled     = var.client_affinity_enabled
  connection_strings          = var.connection_strings
  cors_origins                = split(",", var.cors_origins)
  dns_domain                  = var.dns_domain
  dns_resource_group_name     = var.dns_resource_group_name
  docker_image                = var.api
  docker_image_tag            = var.docker_image_tag
  docker_name                 = var.docker_name
  docker_password             = var.docker_password
  docker_registry             = var.docker_registry
  docker_username             = var.docker_username
  host                        = "api.${var.host}"
  hostname                    = "api.${var.hostname}"
  https_only                  = var.https_only
  location                    = var.location
  log_sas_url                 = var.log_sas_url
  name                        = "${local.name}-api"
  resource_group_name         = var.resource_group_name
  service_plan_id             = var.service_plan_id
  virtual_network_subnet_id   = var.virtual_network_subnet_id_api
  zone_name                   = var.zone_name
}