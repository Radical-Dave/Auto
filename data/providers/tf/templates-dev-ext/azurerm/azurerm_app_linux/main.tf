locals {
  app_settings = merge(var.app_settings, local.app_settings_appinsights_dynamic)
  app_settings_appinsights_dynamic = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = "${module.azurerm_application_insights.instrumentation_key}"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=${module.azurerm_application_insights.instrumentation_key}"
  }
}
module "azurerm_app" {
  source       = "../azurerm_linux_web_app"
  app_settings = local.app_settings
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  health_check_path       = var.health_check_path
  https_only              = var.https_only
  #identity { type = "SystemAssigned"}
  location            = var.location
  log_sas_url         = var.log_sas_url
  name                = var.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  settings            = var.settings
  tags                = var.tags
}
data "azurerm_dns_zone" "parent" {
  name                = var.zone_name
  resource_group_name = var.dns_resource_group_name
}
# module azurerm_dns_zone {
#   source="../azurerm_dns_zone"
#   name=local.zone_name
#   resource_group_name=local.resource_group_name
# }
module "azurerm_dns_cname_record" {
  depends_on          = [data.azurerm_dns_zone.parent]
  source              = "../azurerm_dns_cname_record"
  name                = var.host
  record              = module.azurerm_app.default_site_hostname
  resource_group_name = var.dns_resource_group_name
  #target_resource_id=module.azurerm_app_service_api.id
  zone_name = data.azurerm_dns_zone.parent.name #local.zone_name#module.azurerm_dns_zone.name
}
module "azurerm_dns_txt_record" {
  depends_on          = [data.azurerm_dns_zone.parent]
  source              = "../azurerm_dns_txt_record"
  name                = var.host
  record              = [{ value = module.azurerm_app.custom_domain_verification_id }]
  resource_group_name = var.dns_resource_group_name
  zone_name           = data.azurerm_dns_zone.parent.name #local.zone_name#module.azurerm_dns_zone.name
}
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [module.azurerm_dns_txt_record]
}
module "azurerm_app_service_custom_hostname_binding" {
  app_service_name = module.azurerm_app.name
  depends_on       = [module.azurerm_app, module.azurerm_dns_cname_record, module.azurerm_dns_txt_record]
  hostname         = var.hostname
  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = var.resource_group_name
  source              = "../azurerm_app_service_custom_hostname_binding"
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
  location            = var.location
  name                = "${var.name}-law"
  resource_group_name = var.resource_group_name
  retention_in_days   = 30
  sku                 = "PerGB2018"
  source              = "../azurerm_log_analytics_workspace"
}
module "azurerm_application_insights" {
  application_type    = "web"
  location            = var.location
  name                = "${var.name}-ai"
  resource_group_name = var.resource_group_name
  source              = "../azurerm_application_insights"
  workspace_id        = module.azurerm_log_analytics_workspace.id
}