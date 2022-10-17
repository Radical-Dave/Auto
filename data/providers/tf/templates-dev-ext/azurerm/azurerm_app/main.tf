locals {
  app_settings = merge(try(var.app_settings, {}), local.app_settings_appinsights_dynamic)
  app_settings_appinsights_dynamic = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = "${module.azurerm_application_insights.instrumentation_key}"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=${module.azurerm_application_insights.instrumentation_key}"
  }
  dns_resource_group_name = length(var.dns_resource_group_name != null ? var.dns_resource_group_name : "") > 0 ? var.dns_resource_group_name : "base"
  health_check_path       = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : length(regexall(".*-api.*", local.name)) > 0 ? "/swagger/v1/swagger.json" : "/health"
  host                    = length(var.host != null ? var.host : "") > 0 ? var.host : var.resource_group_name
  hostname                = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : "${local.host}.${var.dns_domain}"
  name                    = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-app" : "project-app"
  resource_group_name     = length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : replace(var.name, "-app", "")
  #zone_name=length(var.zone_name != null ? var.zone_name : "") > 0 ? var.zone_name : replace(local.hostname,"api.","")
  zone_name = length(var.zone_name != null ? var.zone_name : "") > 0 ? var.zone_name : var.dns_domain
}
module "azurerm_windows_web_app" {
  source = "../azurerm_windows_web_app"
  #app_settings=length(regexall(".*-core-api.*", local.name))>0 ? local.app_settings_api_core : length(regexall(".*-api.*", local.name))>0 ? local.app_settings_api : local.app_settings
  app_settings            = local.app_settings
  client_affinity_enabled = var.client_affinity_enabled
  #connection_strings=var.connection_strings
  #cors_origins=var.cors_origins
  https_only = var.https_only
  location   = var.location
  #log_sas_url=var.log_sas_url
  name                = local.name
  resource_group_name = local.resource_group_name
  service_plan_id     = var.service_plan_id
  settings            = var.settings
  tags                = var.tags
  #virtual_network_subnet_id=var.virtual_network_subnet_id
}
data "azurerm_dns_zone" "parent" {
  name                = local.zone_name
  resource_group_name = local.dns_resource_group_name
}
# data azurerm_dns_zone azurerm_dns_zone {
#   name=replace(local.hostname,"api.","")
#   resource_group_name=local.resource_group_name
# }
# module azurerm_dns_zone {
#   source="../azurerm_dns_zone"
#   name=local.zone_name
#   resource_group_name=local.resource_group_name
# }
module "azurerm_windows_web_app_dns_cname_record" {
  depends_on          = [data.azurerm_dns_zone.parent]
  source              = "../azurerm_dns_cname_record"
  name                = local.host #length(regexall(".*api..*", local.host)) > 0 ? "api" : local.host
  record              = module.azurerm_windows_web_app.default_hostname
  resource_group_name = local.dns_resource_group_name #length(regexall(".*api..*", local.host)) > 0 ? local.resource_group_name : local.dns_resource_group_name
  #target_resource_id=module.azurerm_windows_web_app_api.id  
  zone_name = data.azurerm_dns_zone.parent.name #length(regexall(".*api..*", local.host)) > 0 ? data.azurerm_dns_zone.azurerm_dns_zone.name : data.azurerm_dns_zone.parent.name
}
module "azurerm_windows_web_app_dns_txt_record" {
  #depends_on=[module.azurerm_dns_zone]
  source              = "../azurerm_dns_txt_record"
  name                = local.host #"www"#name=local.host#length(regexall(".*..*", local.host)) > 0 ? split(".", local.host)[0] : ""
  record              = [{ value = module.azurerm_windows_web_app.custom_domain_verification_id }]
  resource_group_name = local.dns_resource_group_name
  zone_name           = data.azurerm_dns_zone.parent.name #data.azurerm_dns_zone.azurerm_dns_zone.name#local.zone_name
}
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [module.azurerm_windows_web_app_dns_txt_record]
}
module "azurerm_app_service_custom_hostname_binding" {
  depends_on          = [module.azurerm_windows_web_app, module.azurerm_windows_web_app_dns_txt_record]
  source              = "../azurerm_app_service_custom_hostname_binding"
  app_service_name    = module.azurerm_windows_web_app.name
  hostname            = local.hostname #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = local.resource_group_name
}
module "azurerm_app_service_managed_certificate" {
  source                     = "../azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
}
module "azurerm_app_service_certificate_binding" {
  source              = "../azurerm_app_service_certificate_binding"
  certificate_id      = module.azurerm_app_service_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
}
module "azurerm_log_analytics_workspace" {
  source = "../azurerm_log_analytics_workspace"
  #application_type="web"
  location            = var.location
  name                = "${local.name}-law"
  resource_group_name = local.resource_group_name
  retention_in_days   = 30
  sku                 = "PerGB2018"
}
module "azurerm_application_insights" {
  source              = "../azurerm_application_insights"
  application_type    = "web"
  location            = var.location
  name                = "${local.name}-ai"
  resource_group_name = local.resource_group_name
  workspace_id        = module.azurerm_log_analytics_workspace.id
}