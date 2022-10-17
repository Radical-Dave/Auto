locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}"
  app_settings = {
    "ASPNETCORE_ENVIRONMENT"              = length(regexall("${var.host_root}-*", local.name)) > 0 ? length(regexall(".*-qa*", local.name)) > 0 ? "Staging" : "Development" : "Production"
    "DOCKER_ENABLE_CI"                    = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.docker_username
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
  api_core_settings = {
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "disabled"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "disabled"
    "AUTH0_DB_CONNECTION"                             = "Username-Password-Authentication"
    "DiagnosticServices_EXTENSION_VERSION"            = "disabled"
    "DOCKER_ENABLE_CI"                                = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"                 = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"                      = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"                 = var.docker_username
    "FTP_projectPAY_PRGRIN_FTPPASSWORD"               = var.projectpay_password
    "FTP_projectPAY_PRGRIN_FTPUSERNAME"               = var.projectpay_username
    "FTP_projectPAY_URI"                              = var.projectpay_uri
    "FTP_PHICURE_PRGRIN_FTPPASSWORD"                  = var.phicure_password
    "FTP_PHICURE_PRGRIN_FTPUSERNAME"                  = var.phicure_username
    "FTP_PHICURE_PORT"                                = "22"
    "FTP_PHICURE_URI"                                 = var.phicure_uri
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "MANAGEMENT_API_AUDIENCE"                         = "https://project-dev.us.auth0.com/api/v2/"
    "project_API_KEY"                               = var.project_api_key
    "project_API_AUDIENCE"                          = length(var.project_api_audience != null ? var.project_api_audience : "") > 0 ? var.project_api_audience : "https://api.${var.hostname}"
    "project_API_AUTHORITY"                         = var.project_api_authority
    "project_API_AUTH0_ORG"                         = var.project_api_auth0_org
    "project_API_CLIENT_ID"                         = var.project_api_client_id
    "project_API_CLIENT_SECRET"                     = var.project_api_client_secret
    "project_API_ORIGINS"                           = var.project_api_origins
    "project_NO_INIT_PROCS"                         = "false"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "WEBSITE_HTTPLOGGING_RETENTION_DAYS"              = "1"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"             = "false"
    "WEBSITES_PORT"                                   = "80"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "default"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }
  api_settings = {
    "DOCKER_ENABLE_CI"                    = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.docker_username
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "80"
  }
}
module "azurerm_app" {
  source                      = "../azurerm_app"
  app_settings                = local.app_settings
  app_sp                      = var.app_sp
  client_affinity_enabled     = var.client_affinity_enabled
  dns_domain                  = var.dns_domain
  dns_resource_group_name     = var.dns_resource_group_name
  docker_image                = var.app
  docker_image_tag            = var.docker_image_tag
  docker_name                 = var.docker_name
  docker_password             = var.docker_password
  docker_registry             = var.docker_registry
  docker_username             = var.docker_username
  health_check_path           = var.health_check_path
  host                        = var.host
  hostname                    = var.hostname
  https_only                  = var.https_only
  location                    = var.location
  log_sas_url                 = var.log_sas_url
  name                        = "${local.name}-app"
  project_api_key           = local.project_api_key
  project_api_audience      = local.project_api_audience
  project_api_authority     = local.project_api_authority
  project_api_auth0_org     = local.project_api_auth0_org
  project_api_client_id     = local.project_api_client_id
  project_api_client_secret = local.project_api_client_secret
  project_api_origins       = local.project_api_origins
  resource_group_name         = var.resource_group_name
  service_plan_id             = var.service_plan_id
  zone_name                   = var.zone_name
}
module "azurerm_api" {
  source                      = "../azurerm_app"
  app_settings                = var.api != merge(local.app_settings, "vantage-core-api" ? local.api_settings : local.api_core_settings)
  app_sp                      = var.app_sp
  client_affinity_enabled     = var.client_affinity_enabled
  connection_strings          = var.connection_strings
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
  project_api_key           = local.project_api_key
  project_api_audience      = local.project_api_audience
  project_api_authority     = local.project_api_authority
  project_api_auth0_org     = local.project_api_auth0_org
  project_api_client_id     = local.project_api_client_id
  project_api_client_secret = local.project_api_client_secret
  project_api_origins       = local.project_api_origins
  resource_group_name         = var.resource_group_name
  service_plan_id             = var.service_plan_id
  zone_name                   = var.zone_name
}