locals {
  dns_domain              = var.DNS_DOMAIN != null ? var.DNS_DOMAIN : "project.com" #local.dns_azuredefault
  dns_domain_azure        = var.DNS_DOMAIN_AZURE != null ? var.DNS_DOMAIN_AZURE : "azurewebsites.net"
  dns_resource_group_name = length(var.DNS_RESOURCE_GROUP_NAME != null ? var.DNS_RESOURCE_GROUP_NAME : "") > 0 ? var.DNS_RESOURCE_GROUP_NAME : "base"
  docker_image_tags       = split(length(var.DOCKER_IMAGE_TAGS != null ? var.DOCKER_IMAGE_TAGS : "") > 0 ? var.DOCKER_IMAGE_TAGS : "dev,demo,qa,test,www", ",")
  docker_image_tag        = local.envname                                                                                     #contains(local.docker_image_tags,local.envname) ? local.envname : "latest"
  docker_name             = length(var.DOCKER_NAME != null ? var.DOCKER_NAME : "") > 0 ? var.DOCKER_NAME : "baseterraformacr" #"projectacrrepo" #"coredevopsacr"
  docker_password         = length(var.DOCKER_PASSWORD != null ? var.DOCKER_PASSWORD : "") > 0 ? var.DOCKER_PASSWORD : ""
  docker_registry         = length(var.DOCKER_REGISTRY != null ? var.DOCKER_REGISTRY : "") > 0 ? var.DOCKER_REGISTRY : "${local.docker_name}.azurecr.io"
  docker_username         = length(var.DOCKER_USERNAME != null ? var.DOCKER_USERNAME : "") > 0 ? var.DOCKER_USERNAME : length(local.docker_name) > 0 ? local.docker_name : null
  envname                 = length(var.ENVNAME != null ? var.ENVNAME : "") > 0 ? var.ENVNAME : "dev"
  # ext={
  #   "DOCKER_API"="vantage-core-api:${local.docker_image_tag}"
  #   "docker_image"="vantage-ng-app:${local.docker_image_tag}"
  #   #"docker_image_tagS"=local.docker_image_tags
  #   "docker_image_tag"=local.docker_image_tag
  #   #"docker_image_tagS"=local.docker_image_tags
  #   "DOCKER_NAME"=local.docker_name
  #   "DOCKER_PASSWORD"=length(var.DOCKER_PASSWORD != null ? var.DOCKER_PASSWORD : "") > 0 ? var.DOCKER_PASSWORD : ""
  #   "DOCKER_REGISTRY"=length(var.DOCKER_REGISTRY != null ? var.DOCKER_REGISTRY : "") > 0 ? var.DOCKER_REGISTRY : "${local.docker_name}.azurecr.io"
  #   "DOCKER_USERNAME"=length(var.DOCKER_USERNAME != null ? var.DOCKER_USERNAME : "") > 0 ? var.DOCKER_USERNAME : length(local.docker_name)>0 ? local.docker_name : null
  #   "FTP_projectPAY_PRGRIN_FTPPASSWORD"=var.FTP_projectPAY_PRGRIN_FTPPASSWORD
  #   "FTP_projectPAY_PRGRIN_FTPUSERNAME"=var.FTP_projectPAY_PRGRIN_FTPUSERNAME
  #   "FTP_projectPAY_URI"=var.FTP_projectPAY_URI
  #   "FTP_PHICURE_PRGRIN_FTPPASSWORD"=var.FTP_PHICURE_PRGRIN_FTPPASSWORD
  #   "FTP_PHICURE_PRGRIN_FTPUSERNAME"=var.FTP_PHICURE_PRGRIN_FTPUSERNAME
  #   "FTP_PHICURE_PORT"=var.FTP_PHICURE_PORT
  #   "FTP_PHICURE_URI"=var.FTP_PHICURE_URI
  #   "project_API_KEY"=length(var.project_API_KEY != null ? var.project_API_KEY : "") > 0 ? var.project_API_KEY : ""
  #   "project_API_AUDIENCE"=length(var.project_API_AUDIENCE != null ? var.project_API_AUDIENCE : "") > 0 ? var.project_API_AUDIENCE : "https://api.${local.hostname}"
  #   "project_API_AUTHORITY"=length(var.project_API_AUTHORITY != null ? var.project_API_AUTHORITY : "") > 0 ? var.project_API_AUTHORITY : "https://project-dev.us.auth0.com"
  #   "project_API_AUTH0_ORG"=length(var.project_API_AUTH0_ORG != null ? var.project_API_AUTH0_ORG : "") > 0 ? var.project_API_AUTH0_ORG : ""
  #   "project_API_CLIENT_ID"=length(var.project_API_CLIENT_ID != null ? var.project_API_CLIENT_ID : "") > 0 ? var.project_API_CLIENT_ID : ""
  #   "project_API_CLIENT_SECRET"=length(var.project_API_CLIENT_SECRET != null ? var.project_API_CLIENT_SECRET : "") > 0 ? var.project_API_CLIENT_SECRET : ""
  #   "project_API_ORIGINS"=length(var.project_API_ORIGINS != null ? var.project_API_ORIGINS : "") > 0 ? var.project_API_ORIGINS : local.urls    
  # }
  host                        = length(var.HOST != null ? var.HOST : "") > 0 ? var.HOST : length(local.prefix) > 0 ? (local.prefix != local.host_root ? "${local.envname}.${local.prefix}" : local.envname) : local.resource_group_name
  hostname                    = length(var.HOSTNAME != null ? var.HOSTNAME : "") > 0 ? var.HOSTNAME : "${local.host}.${local.dns_domain}"
  host_root                   = replace(local.dns_domain, ".com", "")
  name                        = "${local.prefix}-${local.envname}"
  nsg_rules                   = coalesce(var.nsg_rules, {}) #length(module.azurerm_application_security_group.id) > 0 ? tomap(object({name=module.azurerm_application_security_group[*].namedestination_application_security_group_ids=module.azurerm_application_security_group[*].id})) : {}
  project_api_key           = length(var.project_API_KEY != null ? var.project_API_KEY : "") > 0 ? var.project_API_KEY : ""
  project_api_audience      = length(var.project_API_AUDIENCE != null ? var.project_API_AUDIENCE : "") > 0 ? var.project_API_AUDIENCE : "https://api.${local.hostname}"
  project_api_authority     = length(var.project_API_AUTHORITY != null ? var.project_API_AUTHORITY : "") > 0 ? var.project_API_AUTHORITY : "https://project-dev.us.auth0.com"
  project_api_client_id     = length(var.project_API_CLIENT_ID != null ? var.project_API_CLIENT_ID : "") > 0 ? var.project_API_CLIENT_ID : ""
  project_api_client_secret = length(var.project_API_CLIENT_SECRET != null ? var.project_API_CLIENT_SECRET : "") > 0 ? var.project_API_CLIENT_SECRET : ""
  project_api_origins       = length(var.project_API_ORIGINS != null ? var.project_API_ORIGINS : "") > 0 ? var.project_API_ORIGINS : local.urls
  prefix                      = length(var.PREFIX != null ? var.PREFIX : "") > 0 ? var.PREFIX : "smoke" #Release.DefinitionName
  resource_group_name         = length(var.RESOURCE_GROUP_NAME != null ? var.RESOURCE_GROUP_NAME : "") > 0 ? var.RESOURCE_GROUP_NAME : local.prefix != local.host_root ? "${local.name}" : local.envname
  scopes                      = [{ description = "Read all accounts", value = "accounts:read" }, { description = "Read client permissions", value = "read:role_client_grants" }, { description = "Create role members", value = "create:role_members" }, { description = "Read permissions", value = "read:role_member" }, { description = "Create a role", value = "create:roles" }, { description = "Read all roles", value = "read:roles" }, { description = "Update roles", value = "update:roles" }, { description = "Create and edit users", value = "users:manage" }, ]
  #address_space=length(var.ADDRESS_SPACE != null ? var.ADDRESS_SPACE : "") > 0 ? var.ADDRESS_SPACE : tolist(null)
  #subnets=length(var.SUBNETS != null ? var.SUBNETS : "") > 0 ? var.SUBNETS : tolist(null)

  subnet_id               = 1
  subnet_address_prefixes = length(var.subnet_address_prefix != null ? var.subnet_address_prefix : "") > 0 ? [var.subnet_address_prefix] : ["10.0.1.0/24"]
  tags                    = merge(var.tags, { environment = local.envname })
  urls                    = length(var.URLS != null ? var.URLS : "") > 0 ? var.URLS : "https://${local.hostname},https://api.${local.hostname},https://${local.name}-app.${local.dns_domain_azure},https://${local.name}-api.${local.dns_domain_azure}${replace(length(regexall("www..*", local.name)) > 0 ? ",https://${local.hostname},https://api.${local.hostname}" : "", "www.", "")}${local.resource_group_name != "dev" ? "" : ",http://localhost:3000,http://localhost:4200"}"
  urls_list               = tolist(split(",", local.urls))
  vault_name              = length(var.VAULT_NAME != null ? var.VAULT_NAME : "") > 0 ? var.VAULT_NAME : "base-terraform-kv"
  vault_resource_group    = length(var.VAULT_RESOURCE_GROUP != null ? var.VAULT_RESOURCE_GROUP : "") > 0 ? var.VAULT_RESOURCE_GROUP : "base-terraform-rg"
  zone_name               = length(var.zone_name != null ? var.zone_name : "") > 0 ? var.zone_name : local.dns_domain
}
# failed - insufficient privileges to complete the operation - Listing service principals
# data azuread_service_principal MicrosoftWebApp {
#   application_id="abfa0a7c-a6b6-4736-8310-5855508787cd"
# }
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
module "azurerm_resource_group" {
  source   = "../../templates/azurerm/azurerm_resource_group"
  location = var.LOCATION
  name     = local.resource_group_name
}
module "azurerm_storage_account" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../../templates/azurerm/azurerm_storage_account"
  name                = var.sa_name
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_service_plan_windows" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../templates/azurerm/azurerm_service_plan"
  #kind="Linux"#kind="app,container,linux", #kind="xenon", #kind="app,linux,container"
  location            = module.azurerm_resource_group.location
  name                = "${local.name}-asp-windows"
  os_type             = "Windows" #Linux
  reserved            = true
  resource_group_name = module.azurerm_resource_group.name
  #sku_name="P1v2"
  #worker_count=3
  sku = "P1v2"
}
module "azurerm_windows_function_app" {
  depends_on          = [data.azurerm_key_vault.kv, module.azurerm_resource_group, module.azurerm_storage_account]
  source              = "../../templates/azurerm/azurerm_windows_function_app"
  lifecycle_ignores   = ["JOB_FUNCTION_BASE_URL", "SCHEDULER_TIMER_TRIGGER"]
  name                = "${module.azurerm_resource_group.name}-sched-func"
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  service_plan_id     = module.azurerm_service_plan_windows.id
  #site_config=var.site_config
  site_config = {
    app_settings = {
      "AzureWebJobsSecretStorageType"        = "keyvault"
      "AzureWebJobsSecretStorageKeyVaultUri" = data.azurerm_key_vault.kv.vault_uri
      "JOB_FUNCTION_BASE_URL"                = "https://${module.azurerm_resource_group.name}-sched-func.azurewebsites.net/api/JobRunner?code="
      "project_API_AUDIENCE"               = local.project_api_audience
      "project_API_CLIENT_ID"              = local.project_api_client_id
      "project_API_CLIENT_SECRET"          = local.project_api_client_secret
      "project_BASE_URL"                   = local.project_api_audience
      "SCHEDULER_TIMER_TRIGGER"              = "0 */10 * * * *"
    }
  }
  # source_control {
  #   repo_url=var.FUNCTION_APP_REPO
  #   branch="master"
  # }  
  storage_account_name = module.azurerm_storage_account.name
  #app_service_plan_tier="Dynamic"
  #app_service_plan_size="Y1"
  #kind="FunctionApp"
  #reserved=true
  #virtual_network_subnet_id=module.azurerm_virtual_network.id
}
module "azurerm_app_service_source_control" {
  depends_on             = [module.azurerm_windows_function_app]
  source                 = "../../templates/azurerm/azurerm_app_service_source_control"
  app_id                 = module.azurerm_windows_function_app.id
  repo_url               = var.FUNCTION_APP_REPO
  rollback_enabled       = false
  use_manual_integration = false
}