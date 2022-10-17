locals {
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? local.prefix) != "project" ? "${var.prefix}-${var.envname}-app" : "-${var.envname}" : "project-app"
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}-app"
  #prefix=length(var.prefix != null ? var.prefix : "") > 0 ? var.prefix : "smoke" #Release.DefinitionName
  #envname=length(var.envname != null ? var.envname : "") > 0 ? var.envname : "test" #Release.EnvironmentName
  #resource_group_name=length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : "${var.prefix}-${var.envname}"
  resource_group_name     = length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : replace(var.name, "-app", "")
  defaultdomain           = var.defaultdomain != null ? var.defaultdomain : "azurewebsites.net" #coalesce(var.defaultdomain, "azurewebsites.net")
  dns_resource_group_name = length(var.dns_resource_group_name != null ? var.dns_resource_group_name : "") > 0 ? var.dns_resource_group_name : "base"
  zone_name               = length(var.zone_name != null ? var.zone_name : "") > 0 ? var.zone_name : local.defaultdomain
  #domain=coalesce(var.domain, local.defaultdomain)
  domain = length(var.domain != null ? var.domain : "") > 0 ? var.domain : local.defaultdomain
  #hostname=coalesce(var.HOSTNAME, "${var.RESOURCE_GROUP_NAME}.${local.domain}")
  #hostname=coalesce(var.HOSTNAME, length(var.prefix) > 0 ? (var.prefix != "project" ? "${var.envname}.${var.prefix}.${local.domain}" : "${var.prefix}.${local.domain}") : "${local.resource_group_name}.${local.domain}")
  #host=coalesce(var.HOST, length(var.prefix) > 0 ? (var.prefix != "project" ? "${var.prefix}.${var.envname}" : var.envname) : local.resource_group_name)
  #host=length(var.host != null ? var.host : "") > 0 ? var.host : length(var.prefix) > 0 ? (var.prefix != "project" ? "${var.envname}.${var.prefix}" : var.envname) : local.resource_group_name
  #host=length(var.host != null ? var.host : "") > 0 ? var.host : length(var.prefix) > 0 ? "${var.envname}.${var.prefix}" : var.envname
  health_check_path = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : length(regexall(".*-api.*", local.name)) > 0 ? "" : "/health"
  #health_check_path=length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : null
  host     = length(var.host != null ? var.host : "") > 0 ? var.host : var.resource_group_name
  hostname = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : "${local.host}.${local.domain}"
  kind     = length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
  site_config = length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
    always_on         = "true"
    ftps_state        = "Disabled"
    health_check_path = local.health_check_path
    scm_type          = "None"
    linux_fx_version  = "DOCKER|${var.docker_registry}/${var.docker_image}:latest"
  }
  scm_type             = length(var.scm_type != null ? var.scm_type : "") > 0 ? var.scm_type : "None"
  vault_name           = length(var.vault_name != null ? var.vault_name : "") > 0 ? var.vault_name : "base-terraform-kv"
  vault_resource_group = length(var.vault_resource_group != null ? var.vault_resource_group : "") > 0 ? var.vault_resource_group : "base-terraform-rg"
  always_on            = length(var.always_on != null ? var.always_on : "") > 0 ? var.always_on : "true"
  fx_version           = length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:latest" : null
  app_settings = {
    "DOCKER_ENABLE_CI"                    = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.docker_username
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
  api_core_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = "${module.azurerm_application_insights.instrumentation_key}"
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "disabled"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = "InstrumentationKey=${module.azurerm_application_insights.instrumentation_key}"
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "disabled"
    "ASPNETCORE_ENVIRONMENT"                          = "Development"
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
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = "${module.azurerm_application_insights.instrumentation_key}"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=${module.azurerm_application_insights.instrumentation_key}"
    "DOCKER_ENABLE_CI"                      = "true"
    "DOCKER_REGISTRY_SERVER_PASSWORD"       = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"            = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"       = var.docker_username
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"   = "false"
    "WEBSITES_PORT"                         = "80"
    "ASPNETCORE_ENVIRONMENT"                = "Development"
  }
}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
module "azurerm_app_service" {
  source       = "../azurerm_linux_web_app"
  app_settings = local.app_settings
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  #cors_origins=var.cors_origins
  docker_image = var.docker_image
  #docker_name=var.docker_name
  docker_registry = var.docker_registry
  #docker_username=var.docker_username
  health_check_path = local.health_check_path
  https_only        = var.https_only
  #identity { type = "SystemAssigned"}
  location            = local.location
  log_sas_url         = var.log_sas_url
  name                = local.name
  resource_group_name = local.resource_group_name
  #app_service_plan_id=var.service_plan_id
  service_plan_id = var.service_plan_id
  #virtual_network_subnet_id=var.virtual_network_subnet_id
  #site_config = var.site_config
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
  # site_config {
  #     #scm_type=local.site_config.scm_type
  #     #always_on=local.site_config.always_on
  #     #linux_fx_version=local.site_config.linux_fx_version
  #     #health_check_path=local.site_config.health_check_path
  #     acr_use_managed_identity_credentials=false
  #     http2_enabled=true  
  # }  
  site_config = {
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
    linux_fx_version = local.fx_version
    # application_stack {
    #   docker_container_name="${var.docker_registry}/${var.docker_image}"
    #   docker_image_tag="latest"
    # }
    vnet_route_all_enabled = false
  }
  tags = var.tags
}
# data azurerm_dns_zone parent {
#   name=local.zone_name
#   resource_group_name=local.dns_resource_group_name
# }
# module azurerm_dns_zone {
#   source="../azurerm_dns_zone"
#   name=local.zone_name
#   resource_group_name=local.resource_group_name
# }
# module azurerm_dns_ns_record {
#   depends_on=[module.azurerm_dns_zone]
#   source="../azurerm_dns_ns_record"
#   name=local.zone_name
#   zone_name=data.azurerm_dns_zone.parent.name
#   records=module.azurerm_dns_zone.name_servers
#   resource_group_name=data.azurerm_dns_zone.parent.resource_group_name
#   ttl=60  
# }
module "azurerm_app_service_dns_cname_record" {
  # depends_on=[module.azurerm_dns_zone]
  source              = "../azurerm_dns_cname_record"
  name                = "www" #local.host
  resource_group_name = local.resource_group_name
  zone_name           = local.hostname
  # dns_resource_group_name=module.azurerm_dns_zone.resource_group_name
  dns_resource_group_name = local.resource_group_name
  #target_resource_id=module.azurerm_app_service_api.id
  record = module.azurerm_app_service.default_site_hostname
}
module "azurerm_app_service_dns_txt_record" {
  #depends_on=[module.azurerm_dns_zone]
  source                  = "../azurerm_dns_txt_record"
  name                    = "www" #name=local.host#length(regexall(".*..*", local.host)) > 0 ? split(".", local.host)[0] : ""
  record                  = [{ value = module.azurerm_app_service.custom_domain_verification_id }]
  resource_group_name     = local.resource_group_name
  zone_name               = local.hostname
  dns_resource_group_name = local.resource_group_name
}
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [module.azurerm_app_service_dns_txt_record]
}

module "azurerm_app_service_custom_hostname_binding" {
  depends_on          = [module.azurerm_app_service, module.azurerm_app_service_dns_txt_record]
  source              = "../azurerm_app_service_custom_hostname_binding"
  app_service_name    = module.azurerm_app_service.name
  hostname            = local.hostname
  resource_group_name = local.resource_group_name
}
module "azurerm_app_service_managed_certificate" {
  source                     = "../azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
}
module "azurerm_key_vault_secret_ssl_thumbprint" {
  source       = "../azurerm_key_vault_secret"
  name         = "${local.name}-ssl-thumbprint"
  value        = module.azurerm_app_service_managed_certificate.thumbprint
  key_vault_id = data.azurerm_key_vault.kv.id
}
module "azurerm_app_service_certificate_binding" {
  source              = "../azurerm_app_service_certificate_binding"
  certificate_id      = module.azurerm_app_service_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
  ssl_state           = "SniEnabled"
}

module "azurerm_dns_a_record" {
  #depends_on=[module.azurerm_app_service_custom_hostname_binding]
  source              = "../azurerm_dns_a_record"
  name                = "@"
  records             = [module.azurerm_app_service_custom_hostname_binding.virtual_ip]
  resource_group_name = local.resource_group_name
  ttl                 = 30
  zone_name           = local.hostname
}
module "azurerm_log_analytics_workspace" {
  source              = "../azurerm_log_analytics_workspace"
  name                = "${local.name}-law"
  location            = local.location
  resource_group_name = local.resource_group_name
  #application_type="web"
  sku               = "PerGB2018"
  retention_in_days = 30
}
module "azurerm_application_insights" {
  source              = "../azurerm_application_insights"
  name                = "${local.name}-ai"
  location            = local.location
  resource_group_name = local.resource_group_name
  application_type    = "web"
  workspace_id        = module.azurerm_log_analytics_workspace.id
}