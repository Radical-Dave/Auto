locals {
  app_settings          = var.app_settings #merge(var.app_settings,local.app_settings_appinsights_dynamic)
  app_settings_api      = merge(var.app_settings_api, local.app_settings)
  app_settings_api_core = merge(var.app_settings_api_core, local.app_settings_api)
  # app_settings_appinsights_dynamic={
  #   "APPINSIGHTS_INSTRUMENTATIONKEY"="${module.azurerm_application_insights.instrumentation_key}"
  #   "APPLICATIONINSIGHTS_CONNECTION_STRING"="InstrumentationKey=${module.azurerm_application_insights.instrumentation_key}"
  # }
  dns_resource_group_name = length(var.dns_resource_group_name != null ? var.dns_resource_group_name : "") > 0 ? var.dns_resource_group_name : length(local.resource_group_name) > 0 ? local.resource_group_name : "base"
  #fx_version=length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:${var.docker_image_tag}" : null
  #fx_version=length(var.linux_fx_version != null ? var.linux_fx_version : "")>0 ? var.linux_fx_version : length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:${length(var.docker_image_tag != null ? var.docker_image_tag : "") > 0 ? var.docker_image_tag:"latest"}" : null
  health_check_path   = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : length(regexall(".*-api.*", local.name)) > 0 ? "/swagger/v1/swagger.json" : "/health"
  host                = length(var.host != null ? var.host : "") > 0 ? var.host : var.resource_group_name
  hostname            = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : "${local.host}.${var.dns_domain}"
  name                = length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}-app"
  resource_group_name = length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? var.resource_group_name : replace(var.name, "-app", "")
  # site_config=length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
  #   always_on=var.always_on
  #   ftps_state="Disabled"
  #   health_check_path=local.health_check_path
  #   scm_type="None"
  #   linux_fx_version=local.fx_version#"DOCKER|${var.docker_registry}/${var.docker_image}:latest"    
  # }
  zone_name = length(var.zone_name != null ? var.zone_name : "") > 0 ? var.zone_name : var.dns_domain
}
module "azurerm_app_service" {
  source       = "../azurerm_linux_web_app"
  app_settings = local.app_settings
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  connection_strings      = var.connection_strings
  cors_origins            = var.cors_origins
  docker_image            = var.docker_image
  docker_image_tag        = var.docker_image_tag
  #docker_name=var.docker_name
  docker_registry = var.docker_registry
  #docker_username=var.docker_username
  health_check_path = local.health_check_path
  https_only        = var.https_only
  #identity { type = "SystemAssigned"}
  location            = var.location
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
  # site_config={
  #   #scm_type=local.site_config.scm_type
  #   #always_on=local.site_config.always_on
  #   #linux_fx_version=local.site_config.linux_fx_version
  #   #health_check_path=local.site_config.health_check_path
  #   acr_use_managed_identity_credentials=false
  #   always_on=var.always_on
  #   ftps_state="Disabled"
  #   health_check_path=local.health_check_path
  #   http2_enabled=true
  #   #linux_fx_version=local.fx_version
  #   number_of_workers=3
  #   scm_type="None"
  #   #windows_fx_version=local.windows_fx_version
  #   #linux_fx_version=local.fx_version
  #   # application_stack {
  #   #   docker_container_name="${var.docker_registry}/${var.docker_image}"
  #   #   docker_image_tag="latest"
  #   # }
  #   vnet_route_all_enabled=false
  # }
  tags = var.tags
}
data "azurerm_dns_zone" "parent" {
  name                = local.zone_name
  resource_group_name = local.dns_resource_group_name
}
# module azurerm_dns_zone {
#   source="../azurerm_dns_zone"
#   name=local.zone_name
#   resource_group_name=local.resource_group_name
# }
module "azurerm_app_service_dns_cname_record" {
  depends_on          = [data.azurerm_dns_zone.parent]
  source              = "../azurerm_dns_cname_record"
  name                = local.host
  record              = module.azurerm_app_service.default_site_hostname
  resource_group_name = local.dns_resource_group_name
  #target_resource_id=module.azurerm_app_service_api.id
  zone_name = data.azurerm_dns_zone.parent.name #local.zone_name#module.azurerm_dns_zone.name
}
module "azurerm_app_service_dns_txt_record" {
  depends_on          = [data.azurerm_dns_zone.parent]
  source              = "../azurerm_dns_txt_record"
  name                = local.host
  record              = [{ value = module.azurerm_app_service.custom_domain_verification_id }]
  resource_group_name = local.dns_resource_group_name
  zone_name           = data.azurerm_dns_zone.parent.name #local.zone_name#module.azurerm_dns_zone.name
}
resource "time_sleep" "wait_15_seconds" {
  create_duration = "15s"
  depends_on      = [module.azurerm_app_service_dns_txt_record]
}
module "azurerm_app_service_custom_hostname_binding" {
  depends_on       = [module.azurerm_app_service, module.azurerm_app_service_dns_cname_record, module.azurerm_app_service_dns_txt_record]
  source           = "../azurerm_app_service_custom_hostname_binding"
  app_service_name = module.azurerm_app_service.name
  #defaultdomain=local.defaultdomain
  #hostname=module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
  #hostname=module.azurerm_dns_zone.hostname
  #hostname="api.${local.hostname}"

  #prefix="api.dev"
  #hostname=local.hostname

  #name="api.$(local.hostname)"
  #prefix="api.dev"
  #hostname=local.hostname
  #hostname="api.${local.hostname}"
  hostname = local.hostname
  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
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
# module azurerm_log_analytics_workspace {
#   source="../azurerm_log_analytics_workspace"
#   #application_type="web"
#   location=var.location
#   name="${local.name}-law"  
#   resource_group_name=local.resource_group_name    
#   retention_in_days=30
#   sku="PerGB2018"
# }
# module azurerm_application_insights {
#   source="../azurerm_application_insights"
#   application_type="web"  
#   location=var.location
#   name="${local.name}-ai"
#   resource_group_name=local.resource_group_name  
#   workspace_id=module.azurerm_log_analytics_workspace.id
# }