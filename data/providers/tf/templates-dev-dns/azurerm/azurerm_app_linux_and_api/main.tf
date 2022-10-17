locals {
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}" : ""
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : "${var.prefix}-${var.envname}"
  name     = length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}"
  kind     = length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  # site_config=length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
  #   scm_type="None"
  #   always_on="true"
  #   linux_fx_version="DOCKER|${var.docker_registry}/${var.docker_image}:latest"
  #   health_check_path="/health"
  # }
  #AZURE_MONITOR_INSTRUMENTATION_KEY = azurerm_application_insights.my_app_insight.instrumentation_key
  #Settings for private Container Registires
  # app_settings_default={
  #   #"DOCKER_CUSTOM_IMAGE_NAME"="DOCKER|${var.app}"
  #   "DOCKER_ENABLE_CI"="true"
  #   "DOCKER_REGISTRY_SERVER_PASSWORD"=var.docker_password
  #   "DOCKER_REGISTRY_SERVER_URL"=var.docker_registry
  #   "DOCKER_REGISTRY_SERVER_USERNAME"=var.docker_username
  #   "WEBSITES_ENABLE_APP_SERVICE_STORAGE"="false"
  #   "WEBSITE_PULL_IMAGE_OVER_VNET":"true"
  # }
  # api_settings_default={
  #   #"DOCKER_CUSTOM_IMAGE_NAME"="DOCKER|${var.api}"
  #   "DOCKER_ENABLE_CI"="true"
  #   "DOCKER_REGISTRY_SERVER_PASSWORD"=var.docker_password
  #   "DOCKER_REGISTRY_SERVER_URL"=var.docker_registry
  #   "DOCKER_REGISTRY_SERVER_USERNAME"=var.docker_username
  #   "WEBSITES_ENABLE_APP_SERVICE_STORAGE"="false"
  #   "WEBSITE_PULL_IMAGE_OVER_VNET":"true"
  # }
  #app_settings=length(var.app_settings != null ? var.app_settings : "") > 0 ? var.app_settings : local.app_settings_default
  #app_settings=try(length(var.app_settings != null ? var.app_settings : "") > 0 ? var.app_settings : tomap(local.app_settings_default), {})
}
module "azurerm_app" {
  source = "../azurerm_app_linux"
  #app_settings=local.app_settings
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  defaultdomain           = var.defaultdomain
  dns_resource_group_name = var.dns_resource_group_name
  docker_image            = var.app
  docker_name             = var.docker_name
  docker_password         = var.docker_password
  docker_registry         = var.docker_registry
  docker_username         = var.docker_username
  domain                  = var.domain
  #envname=var.envname
  #health_check_path=var.health_check_path
  host                        = var.host
  hostname                    = var.hostname
  https_only                  = var.https_only
  linux_fx_version            = "DOCKER|${var.docker_registry}/${var.app}:latest"
  location                    = local.location
  log_sas_url                 = var.log_sas_url
  name                        = "${local.name}-app"
  project_api_key           = var.project_api_key
  project_api_audience      = var.project_api_audience
  project_api_authority     = var.project_api_authority
  project_api_auth0_org     = var.project_api_auth0_org
  project_api_client_id     = var.project_api_client_id
  project_api_client_secret = var.project_api_client_secret
  project_api_origins       = var.project_api_origins
  #prefix=var.prefix
  resource_group_name = var.resource_group_name
  #app_service_plan_id=var.service_plan_id
  service_plan_id           = var.service_plan_id
  virtual_network_subnet_id = var.virtual_network_subnet_id_app
  zone_name                 = var.zone_name
  #FTP=disabled
  #ARR_Affinity=off
  #healthcheck=disabled
}
module "azurerm_api" {
  source = "../azurerm_app"
  #app_settings=var.api != "vantage-core-api" ? local.api_settings : local.api_core_settings
  app_sp = var.app_sp
  #client_affinity_enabled=var.client_affinity_enabled  
  cors_origins            = split(",", var.project_api_origins)
  connection_strings      = var.connection_strings
  defaultdomain           = var.defaultdomain
  dns_resource_group_name = var.dns_resource_group_name
  docker_image            = var.api
  #docker_name=var.docker_name
  docker_password = var.docker_password
  docker_registry = var.docker_registry
  docker_username = var.docker_username
  domain          = var.domain
  #envname=var.envname
  host                        = "api.${var.host}"
  hostname                    = "api.${var.hostname}"
  https_only                  = var.https_only
  location                    = local.location
  log_sas_url                 = var.log_sas_url
  name                        = "${local.name}-api"
  project_api_key           = var.project_api_key
  project_api_audience      = var.project_api_audience
  project_api_authority     = var.project_api_authority
  project_api_auth0_org     = var.project_api_auth0_org
  project_api_client_id     = var.project_api_client_id
  project_api_client_secret = var.project_api_client_secret
  project_api_origins       = var.project_api_origins
  #prefix=var.prefix
  resource_group_name = var.resource_group_name
  #app_service_plan_id=var.service_plan_id
  service_plan_id           = var.service_plan_id
  virtual_network_subnet_id = var.virtual_network_subnet_id_api
  zone_name                 = var.zone_name
}