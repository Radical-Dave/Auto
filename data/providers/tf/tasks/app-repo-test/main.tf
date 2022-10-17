locals {
  dns_domain              = var.DNS_DOMAIN != null ? var.DNS_DOMAIN : "project.com" #local.dns_azuredefault
  dns_domain_azure        = var.DNS_DOMAIN_AZURE != null ? var.DNS_DOMAIN_AZURE : "azurewebsites.net"
  dns_resource_group_name = length(var.DNS_RESOURCE_GROUP_NAME != null ? var.DNS_RESOURCE_GROUP_NAME : "") > 0 ? var.DNS_RESOURCE_GROUP_NAME : "base"
  envname                 = length(var.ENVNAME != null ? var.ENVNAME : "") > 0 ? var.ENVNAME : "dev"
  host                    = length(var.HOST != null ? var.HOST : "") > 0 ? var.HOST : length(local.prefix) > 0 ? (local.prefix != local.host_root ? "${local.envname}.${local.prefix}" : local.envname) : local.resource_group_name
  hostname                = length(var.HOSTNAME != null ? var.HOSTNAME : "") > 0 ? var.HOSTNAME : "${local.host}.${local.dns_domain}"
  host_root               = replace(local.dns_domain, ".com", "")
  name                    = "${local.prefix}-${local.envname}"
  prefix                  = length(var.PREFIX != null ? var.PREFIX : "") > 0 ? var.PREFIX : "smoke" #Release.DefinitionName
  resource_group_name     = length(var.RESOURCE_GROUP_NAME != null ? var.RESOURCE_GROUP_NAME : "") > 0 ? var.RESOURCE_GROUP_NAME : local.prefix != local.host_root ? "${local.name}" : local.envname
  tags                    = merge(var.tags, { environment = local.envname })
  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = length(regexall("${local.host_root}-*", local.name)) > 0 ? length(regexall(".*-qa*", local.name)) > 0 ? "Staging" : "Development" : "Production"
    #"DOCKER_ENABLE_CI"="true"
    #"DOCKER_REGISTRY_SERVER_PASSWORD"=var.docker_password
    #"DOCKER_REGISTRY_SERVER_URL"="https://${var.docker_registry}"
    #"DOCKER_REGISTRY_SERVER_USERNAME"=var.docker_username
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
module "azurerm_resource_group" {
  source   = "../../templates/azurerm/azurerm_resource_group"
  location = var.LOCATION
  name     = local.resource_group_name
}
module "azurerm_storage_account" {
  source              = "../../templates/azurerm/azurerm_storage_account"
  name                = var.sa_name
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_service_plan" {
  source = "../../templates/azurerm/azurerm_service_plan"
  #kind="Linux"#kind="app,container,linux", #kind="xenon", #kind="app,linux,container"
  location            = module.azurerm_resource_group.location
  name                = "${local.name}-asp"
  os_type             = "Windows"
  reserved            = true
  resource_group_name = module.azurerm_resource_group.name
  #sku_name="P1v2"
  #worker_count=3
  sku = "P1v2"
}
module "azurerm_app_service" {
  source = "../../templates/azurerm/azurerm_windows_web_app"
  #app_settings=length(regexall(".*-core-api.*", local.name))>0 ? local.app_settings_api_core : length(regexall(".*-api.*", local.name))>0 ? local.app_settings_api : local.app_settings
  app_settings = local.app_settings
  #client_affinity_enabled=var.client_affinity_enabled  
  #connection_strings=var.connection_strings
  #cors_origins=var.cors_origins
  docker_image_tag = var.DOCKER_IMAGE
  #docker_image_tag=var.DOCKER_IMAGE_TAGS
  #docker_name=var.DOCKER_NAME
  docker_registry = var.DOCKER_REGISTRY
  git_repo        = var.GIT_REPO
  #health_check_path=local.health_check_path
  #https_only=var.https_only
  location = module.azurerm_resource_group.location
  #log_sas_url=var.log_sas_url
  name                = "${local.name}-app"
  resource_group_name = module.azurerm_resource_group.name
  service_plan_id     = module.azurerm_service_plan.id
  tags                = var.tags
  #virtual_network_subnet_id=var.virtual_network_subnet_id
}