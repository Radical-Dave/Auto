locals {
  defaultdomain = var.defaultdomain != null ? var.defaultdomain : "" #coalesce(var.defaultdomain, "azurewebsites.net")
  domain = coalesce(var.domain, local.defaultdomain)
  hostname = coalesce(var.hostname, "${var.resource_group_name}.${local.domain}")
  location = coalesce(var.location, "eastus")
  #name = coalesce(var.name, "peregrine" # appName? #"${var.resource_group_name}-kvk",)
  vault_name = coalesce(var.vault_name, "${var.resource_group_name}-kv")
  vault_resource_group = coalesce(var.vault_resource_group, length(coalesce(var.resource_group_name,"")) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg")
  nsg_rules = coalesce(var.nsg_rules, {}) #length(module.azurerm_application_security_group.id) > 0 ? tomap(object({name = module.azurerm_application_security_group[*].namedestination_application_security_group_ids = module.azurerm_application_security_group[*].id})) : {}
}
#key_vault_secret_id - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate
data "azuread_service_principal" "MicrosoftWebApp" {
  application_id = "abfa0a7c-a6b6-4736-8310-5855508787cd"
}
data "azurerm_key_vault" "kv" {
  name = local.vault_name
  resource_group_name = local.vault_resource_group
}
data "azurerm_key_vault_secret" "ad_app" {
  name = var.app_sp
  key_vault_id = data.azurerm_key_vault.kv.id
}
# data "azurerm_user_assigned_identity" "assigned_identity_acr_pull" {
#  provider            = azurerm.acr_sub
#  name                = "imagineacrrepo"
#  resource_group_name = "Imagine"
#}
module "azurerm_resource_group" {
  source = "../../templates/azurerm/azurerm_resource_group"
  location = local.location
  resource_group_name = var.resource_group_name  
}
module "azurerm_application_security_group" {
  count = length(var.asgs)
  source = "../../templates/azurerm/azurerm_application_security_group"
  #for_each = var.asgs
  #name = each.value  
  name = var.asgs[count.index]  
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name  
}
module "azurerm_network_security_group" {
  source = "../../templates/azurerm/azurerm_network_security_group"
  name = var.nsg_name
  #asgs = module.azurerm_application_security_group.*.id
  nsg_rules = local.nsg_rules
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name  
}
module "azurerm_virtual_network" {
  source = "../../templates/azurerm/azurerm_virtual_network"
  name = var.vnet_name
  subnets = var.vnet_subnets
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name  
  #address_space = var.address_space
}
module "azurerm_subnet" {
  source = "../../templates/azurerm/azurerm_subnet"
  name = var.vnet_name
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name  
  virtual_network_name = module.azurerm_virtual_network.name
  address_prefixes = var.subnet_address_prefixes
}
module "azurerm_public_ip" {
  source = "../../templates/azurerm/azurerm_public_ip"
  name = var.pip_name
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name  
  #address_prefix = var.address_prefix
}
module "azurerm_network_interface" {
  source = "../../templates/azurerm/azurerm_network_interface"
  name = var.pip_name
  network_security_group_id = [module.azurerm_network_security_group.id]
  resource_group_name = module.azurerm_resource_group.name
  location = module.azurerm_resource_group.location
  #address_prefix = var.address_prefix
  ip_configuration = [{
    name = "${module.azurerm_public_ip.name}-ip"
    private_ip_address_allocation = "Dynamic"
    primary = true
    #gateway_load_balancer_frontend_ip_configuration_id = module.azurerm_public_ip.id #ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id    
    private_ip_address = "${module.azurerm_public_ip.id}"    
    #private_ip_address_version = "${module.azurerm_public_ip.private_ip_address_version}" ? "${module.azurerm_public_ip.private_ip_address_version}" : null
    public_ip_address_id = "${module.azurerm_public_ip.id}"
    subnet_id = module.azurerm_subnet.id
    application_security_group_id = "${module.azurerm_application_security_group[0].id}" 
  }]
}
module "azurerm_network_interface_security_group_association" {
  source = "../../templates/azurerm/azurerm_network_interface_security_group_association"
  # depends_on = [module.azurerm_network_interface, module.azurerm_network_security_group]  
  #for_each = toset("${module.azurerm_network_security_group[*].id}")
  for_each = { for index, value in module.azurerm_network_security_group[*].id : index => value}
  nic_id = module.azurerm_network_interface.id
  nsg_id = each.value
}
module "azurerm_network_interface_application_security_group_association" {
  source = "../../templates/azurerm/azurerm_network_interface_application_security_group_association"
  # depends_on = [module.azurerm_network_interface, module.azurerm_application_security_group]  
  #for_each = toset("${module.azurerm_application_security_group[*].id}")
  for_each = { for index, value in module.azurerm_application_security_group[*].id : index => value}
  nic_id = module.azurerm_network_interface.id
  asg_id = each.value
}
# module "azurerm_network_interface_application_security_group_association" {
#   source = "../../templates/azurerm/azurerm_network_interface_application_security_group_association"
#   depends_on = [module.azurerm_network_interface, module.azurerm_application_security_group]
#   #for_each = module.azurerm_application_security_group.*.id
#   #for_each = { for item in module.azurerm_application_security_group.*.id : item => item}  
#   for_each = toset(module.azurerm_application_security_group[*].id)
#     nic_id = module.azurerm_network_interface.id
#     asg_id = each.value
#   #count = length(var.asgs)
#   #  nic_id = module.azurerm_network_interface.id
#   #  asg_id = var.asgs[count.index]
# }
module "azurerm_mssql_server" {
  source = "../../templates/azurerm/azurerm_mssql_server"
  name = var.dbserver_name
  dbserver_version = var.dbserver_version
  dbserver_login = var.dbserver_login
  dbserver_pwd = var.dbserver_pwd
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  vault_name = local.vault_name
  vault_resource_group = local.vault_resource_group
}
module "azurerm_storage_account" {
  source = "../../templates/azurerm/azurerm_storage_account"
  name = var.sa_name
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_mssql_database" {
  source = "../../templates/azurerm/azurerm_mssql_database"
  name = var.db_name
  sa_endpoint = module.azurerm_storage_account.endpoint
  sa_key = module.azurerm_storage_account.key
  dbserver_id = module.azurerm_mssql_server.id
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_service_plan" {
  source = "../../templates/azurerm/azurerm_service_plan"
  name = var.app_service_plan_name
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  #app_service_plan_tier = "PremiumV2"
  #app_service_plan_size = "P1v2"
  sku = "P1v2"
  #kind = "Linux"
  os_type = "Linux"
  reserved = true
}
# module "azurerm_key_vault_certificate" {
#   source = "../../templates/azurerm/azurerm_key_vault_certificate"  
#   key_vault_id = data.azurerm_key_vault.kv.id
#   name = var.appserviceplan_name
#   resource_group_name = module.azurerm_resource_group.name
# }
# TODO: Doesnt exist yet
# data "azurerm_key_vault_secret" "app_ssl" {
#   name = "${var.resource_group_name}-kvs"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }
# module "azurerm_app_service_certificate" {
#   source = "../../templates/azurerm/azurerm_app_service_certificate"
#   app_service_plan_id = module.azurerm_app_service_plan.id
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name
#   #key_vault_secret_id = module.azurerm_key_vault_certificate.secret_id
#   #key_vault_secret_id = data.azurerm_key_vault_secret.app_ssl.id
# }

# module "azurerm_dns_zone" {
#   source = "../../templates/azurerm/azurerm_dns_zone"
#   defaultdomain = var.defaultdomain
#   resource_group_name = module.azurerm_resource_group.name
# }


# module "azurerm_linux_web_app" {
#   source = "../../templates/azurerm/azurerm_linux_web_app"
#   service_plan_id = module.azurerm_service_plan.id
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name
#   kind = "app,linux,container"
#   docker_app = "vantage-ng-app"
#   docker_repo = var.docker_repo
#   always_on = "true"
#   scm_type = "None"
#   # site_config = {
#   #   scm_type = "GIT"
#   #   always_on = "true"
#   #   linux_fx_version = "DOCKER|${var.dockerrepo}/vantage-ng-app:latest"
#   #   health_check_path = "/health"
#   # }
#   tags = var.tags
# }

module "azurerm_app_service" {
  source = "../../templates/azurerm/azurerm_app_service"
  service_plan_id = module.azurerm_service_plan.id
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  docker_app = "vantage-ng-app"
  docker_repo = var.docker_repo
  linux_fx_version = "DOCKER|${var.docker_repo}/vantage-ng-app:latest"

  #FTP = disabled
  #ARR_Affinity = off
  #healthcheck = disabled

  app_settings = {
    "DOCKER_ENABLE_CI": "true"
    "DOCKER_REGISTERY_SERVER_PASSWORD": "LX1QaQ+spZ6SYE3JmiQoH=uXdeErU4AL"
    "DOCKER_REGISTERY_SERVER_URL": "https://imagineacrrepo.azurecr.io"
    "DOCKER_REGISTERY_SERVER_USERNAME": "imagineacrrepo"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE": "false"
  }
}
module "azurerm_dns_cname_record" {
  source = "../../templates/azurerm/azurerm_dns_cname_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  #prefix = "dev"
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
  #target_resource_id = module.azurerm_app_service.id
  #record = module.azurerm_linux_web_app.default_hostname
  record = module.azurerm_app_service.default_site_hostname
}
module "azurerm_dns_txt_record" {
  source = "../../templates/azurerm/azurerm_dns_txt_record"
  #record = [{value = module.azurerm_app_service.custom_domain_verification_id}]
  #record = [module.azurerm_linux_web_app.custom_domain_verification_id]
  record = [module.azurerm_app_service.custom_domain_verification_id]
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
}

module "azurerm_app_service_custom_hostname_binding" {
  depends_on = [module.azurerm_app_service,module.azurerm_resource_group,module.azurerm_dns_txt_record]
  #depends_on = [module.azurerm_linux_web_app,module.azurerm_resource_group,module.azurerm_dns_txt_record]
  source = "../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
  app_service_name = module.azurerm_app_service.name
  defaultdomain = var.defaultdomain
  #hostname = module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
  #hostname = module.azurerm_dns_zone.hostname
  hostname = local.hostname
  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_app_service_managed_certificate" {
  source = "../../templates/azurerm/azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
}

module "azurerm_app_service_certificate_binding" {
  source = "../../templates/azurerm/azurerm_app_service_certificate_binding"
  certificate_id = module.azurerm_app_service_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_custom_hostname_binding.id
}


module "azurerm_app_service_api" {
  source = "../../templates/azurerm/azurerm_app_service_api"
  name = "${var.resource_group_name}-api"
  #app_service_plan_id = module.azurerm_app_service_plan.id
  service_plan_id = module.azurerm_service_plan.id
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  docker_app = "vantage-core-api"
  docker_repo = var.docker_repo
}
module "azurerm_app_service_api_dns_cname_record" {
  source = "../../templates/azurerm/azurerm_dns_cname_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  name = "api.dev"
  resource_group_name = module.azurerm_resource_group.name
  #record = module.azurerm_app_service_api
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
  #target_resource_id = module.azurerm_app_service_api.id
  record = module.azurerm_app_service_api.default_site_hostname
}
module "azurerm_app_service_api_custom_dns_txt_record" {
  source = "../../templates/azurerm/azurerm_dns_txt_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  #hostname = "admin.${var.resource_group_name}"
  #name = "asuid.api.dev"
  name = "asuid.${module.azurerm_app_service_api.default_site_hostname}"
  record = [module.azurerm_app_service.custom_domain_verification_id]
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
}
module "azurerm_app_service_api_custom_hostname_binding" {
  depends_on = [module.azurerm_app_service_api,module.azurerm_resource_group,module.azurerm_app_service_api_custom_dns_txt_record]
  source = "../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
  app_service_name = module.azurerm_app_service_api.name
  defaultdomain = var.defaultdomain
  #hostname = module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
  #hostname = module.azurerm_dns_zone.hostname
  #hostname = "api.${var.hostname}"

  #prefix = "api.dev"
  #hostname = local.hostname

  #name = "api.$(local.hostname)"
  #prefix = "api.dev"
  #hostname = local.hostname
  hostname = "api.${local.hostname}"

  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_app_service_api_managed_certificate" {
  source = "../../templates/azurerm/azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_api_custom_hostname_binding.id
}
module "azurerm_app_service_api_certificate_binding" {
  source = "../../templates/azurerm/azurerm_app_service_certificate_binding"
  certificate_id = module.azurerm_app_service_api_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_api_custom_hostname_binding.id
}





module "azurerm_app_service_admin" {
  source = "../../templates/azurerm/azurerm_app_service"
  name = "${var.resource_group_name}-admin-app"
  #app_service_plan_id = module.azurerm_app_service_plan.id
  service_plan_id = module.azurerm_service_plan.id
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  docker_app = "vantage-admin-app"
  docker_repo = var.docker_repo
}
module "azurerm_app_service_admin_dns_cname_record" {
  source = "../../templates/azurerm/azurerm_dns_cname_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  name = "admin.dev"
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
  #target_resource_id = module.azurerm_app_service_admin.id
  record = module.azurerm_app_service_admin.default_site_hostname
}
module "azurerm_app_service_admin_custom_dns_txt_record" {
  source = "../../templates/azurerm/azurerm_dns_txt_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  #prefix = "admin"
  #name = "asuid.admin.dev"
  name = "asuid.${module.azurerm_app_service_admin.default_site_hostname}"
  record = [module.azurerm_app_service.custom_domain_verification_id]
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
}
module "azurerm_app_service_admin_custom_hostname_binding" {
  depends_on = [module.azurerm_app_service_admin,module.azurerm_resource_group,module.azurerm_app_service_admin_custom_dns_txt_record]
  source = "../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
  app_service_name = module.azurerm_app_service_admin.name
  defaultdomain = var.defaultdomain
  #hostname = module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
  #hostname = module.azurerm_dns_zone.hostname
  #hostname = "admin.${local.hostname}"
  #prefix = "admin"
  #hostname = local.hostname
  hostname = "admin.${local.hostname}"
  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_app_service_admin_managed_certificate" {
  source = "../../templates/azurerm/azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_admin_custom_hostname_binding.id
}
module "azurerm_app_service_admin_certificate_binding" {
  source = "../../templates/azurerm/azurerm_app_service_certificate_binding"
  certificate_id = module.azurerm_app_service_admin_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_admin_custom_hostname_binding.id
}


module "azurerm_app_service_admin_api" {
  source = "../../templates/azurerm/azurerm_app_service_api"
  name = "${var.resource_group_name}-admin-api"
  #app_service_plan_id = module.azurerm_app_service_plan.id
  service_plan_id = module.azurerm_service_plan.id
  location = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  docker_app = "vantage-admin-api"
  docker_repo = var.docker_repo
}
module "azurerm_app_service_admin_api_dns_cname_record" {
  source = "../../templates/azurerm/azurerm_dns_cname_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  name = "adminapi.dev"
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
  #target_resource_id = module.azurerm_app_service_admin_api.id
  record = module.azurerm_app_service_admin_api.default_site_hostname
}
module "azurerm_app_service_admin_api_custom_dns_txt_record" {
  source = "../../templates/azurerm/azurerm_dns_txt_record"
  #record = {value = module.azurerm_app_service.custom_domain_verification_id}
  #prefix = "adminapi"
  name = "asuid.${module.azurerm_app_service_admin_api.default_site_hostname}"
  record = [module.azurerm_app_service.custom_domain_verification_id]
  resource_group_name = module.azurerm_resource_group.name
  #zone_name = module.azurerm_dns_zone.name
  zone_name = var.dns_zone_name
  dns_resource_group_name = var.dns_resource_group_name
}
module "azurerm_app_service_admin_api_custom_hostname_binding" {
  depends_on = [module.azurerm_app_service_admin_api,module.azurerm_resource_group,module.azurerm_app_service_admin_api_custom_dns_txt_record]
  source = "../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
  app_service_name = module.azurerm_app_service_admin_api.name
  defaultdomain = var.defaultdomain
  #hostname = module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
  #hostname = module.azurerm_dns_zone.hostname
  #hostname = "adminapi.${var.hostname}"
  #prefix = "adminapi"
  #prefix = "adminapi.dev"
  #hostname = local.hostname
  hostname = "adminapi.${local.hostname}"
  #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_app_service_admin_api_managed_certificate" {
  source = "../../templates/azurerm/azurerm_app_service_managed_certificate"
  custom_hostname_binding_id = module.azurerm_app_service_admin_api_custom_hostname_binding.id
}
module "azurerm_app_service_admin_api_certificate_binding" {
  source = "../../templates/azurerm/azurerm_app_service_certificate_binding"
  certificate_id = module.azurerm_app_service_admin_api_managed_certificate.id
  hostname_binding_id = module.azurerm_app_service_admin_api_custom_hostname_binding.id
}


# module "azurerm_network_security_rule" {
#   #count = length(var.nsg_rules)
#   for_each = var.asgs
#   source = "../../templates/azurerm/azurerm_network_security_rule"
#   name = var.nsg_rules[count.index]
#   #name = each.value
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name
# }

# module "azurerm_storage_account" {
#   source = "../../templates/azurerm/azurerm_storage_account"
#   location = module.azurerm_resource_group.location
#   name = "${module.azurerm_resource_group.name}schedulersa"
#   resource_group_name = module.azurerm_resource_group.name  
# }

# module "azurerm_service_plan_functionapp" {
#   source = "../../templates/azurerm/azurerm_service_plan"
#   name = "${module.azurerm_resource_group.name}-fa-asp"
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name
#   sku = "Y1"
#   #app_service_plan_tier = "Dynamic"
#   #app_service_plan_size = "Y1"
#   #kind = "FunctionApp"
#   os_type = "Windows"
#   reserved = true
# }

# module "azurerm_virtual_network" {
#   source = "../../templates/azurerm/azurerm_virtual_network"
#   name = var.vnet_name
#   subnets = var.vnet_subnets
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name  
#   #address_space = var.address_space
# }

# module "azurerm_windows_function_app" {
#   depends_on = [module.azurerm_storage_account]  
#   source = "../../templates/azurerm/azurerm_windows_function_app"
#   name = "${module.azurerm_resource_group.name}-fa-asp"
#   location = module.azurerm_resource_group.location
#   resource_group_name = module.azurerm_resource_group.name
#   service_plan_id = module.azurerm_service_plan_functionapp.id
#   storage_account_name = module.azurerm_storage_account.name
#   #app_service_plan_tier = "Dynamic"
#   #app_service_plan_size = "Y1"
#   #kind = "FunctionApp"
#   #reserved = true
#   virtual_network_subnet_id = module.azurerm_virtual_network.id
#   #site_config = var.site_config
# }