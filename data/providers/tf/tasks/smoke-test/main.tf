locals {
  defaultdomain = var.defaultdomain != null ? var.defaultdomain : "" #coalesce(var.defaultdomain, "azurewebsites.net")
  domain        = coalesce(var.domain, local.defaultdomain)
  hostname      = coalesce(var.hostname, "${var.resource_group_name}.${local.domain}")
  location      = coalesce(var.location, "eastus")
  #name=coalesce(var.name, "project" # appName? #"${var.resource_group_name}-kvk",)
  vault_name           = coalesce(var.vault_name, "${var.resource_group_name}-kv")
  vault_resource_group = coalesce(var.vault_resource_group, length(coalesce(var.resource_group_name, "")) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg")
  nsg_rules            = coalesce(var.nsg_rules, {}) #length(module.azurerm_application_security_group.id) > 0 ? tomap(object({name=module.azurerm_application_security_group[*].namedestination_application_security_group_ids=module.azurerm_application_security_group[*].id})) : {}
}
data "azuread_service_principal" "MicrosoftWebApp" {
  application_id = "abfa0a7c-a6b6-4736-8310-5855508787cd"
}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
data "azurerm_key_vault_secret" "ad_app" {
  name         = var.app_sp
  key_vault_id = data.azurerm_key_vault.kv.id
}
module "azurerm_resource_group" {
  source              = "../../templates/azurerm/azurerm_resource_group"
  location            = local.location
  resource_group_name = var.resource_group_name
}
# module "ag" {
#   source="../../templates/application-gateway"
#   resource_group_name=module.resourcegroup.name
#   location=module.resourcegroup.location
#   address_space=var.address_space
#   subnets=var.subnets
# }
module "azurerm_service_plan" {
  source              = "../../templates/azurerm/azurerm_service_plan"
  name                = var.app_service_plan_name
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  #app_service_plan_tier="PremiumV2"
  #app_service_plan_size="P1v2"
  sku = "P1v2"
  #kind="Linux"
  os_type  = "Linux"
  reserved = true
}
# module "azurerm_key_vault_certificate" {
#   source="../../templates/azurerm/azurerm_key_vault_certificate"  
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name=var.appserviceplan_name
#   resource_group_name=module.azurerm_resource_group.name
# }
# TODO: Doesnt exist yet
# data "azurerm_key_vault_secret" "app_ssl" {
#   name="${var.resource_group_name}-kvs"
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
# module "azurerm_app_service_certificate" {
#   source="../../templates/azurerm/azurerm_app_service_certificate"
#   app_service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   #key_vault_secret_id=module.azurerm_key_vault_certificate.secret_id
#   #key_vault_secret_id=data.azurerm_key_vault_secret.app_ssl.id
# }

# module "azurerm_dns_zone" {
#   source="../../templates/azurerm/azurerm_dns_zone"
#   defaultdomain=var.defaultdomain
#   resource_group_name=module.azurerm_resource_group.name
# }


# module "azurerm_linux_web_app" {
#   source="../../templates/azurerm/azurerm_linux_web_app"
#   service_plan_id=module.azurerm_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   kind="app,linux,container"
#   docker_app="vantage-ng-app"
#   docker_repo=var.docker_repo
#   # site_config={
#   #   scm_type="GIT"
#   #   always_on="true"
#   #   linux_fx_version="DOCKER|${var.dockerrepo}/vantage-ng-app:latest"
#   #   health_check_path="/health"
#   # }
#   tags=var.tags
# }
# module "azurerm_dns_cname_record" {
#   source="../../templates/azurerm/azurerm_dns_cname_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   #prefix="dev"
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
#   #target_resource_id=module.azurerm_app_service.id
#   record=module.azurerm_linux_web_app.default_hostname
# }
# module "azurerm_dns_txt_record" {
#   source="../../templates/azurerm/azurerm_dns_txt_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   record=[module.azurerm_linux_web_app.custom_domain_verification_id]
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
# }

# module "azurerm_app_service_custom_hostname_binding" {
#   depends_on=[module.azurerm_linux_web_app,module.azurerm_resource_group,module.azurerm_dns_txt_record]
#   source="../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_linux_web_app.name
#   defaultdomain=var.defaultdomain
#   #hostname=module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
#   #hostname=module.azurerm_dns_zone.hostname
#   hostname=local.hostname
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module "azurerm_app_service_managed_certificate" {
#   source="../../templates/azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_custom_hostname_binding.id
# }

# module "azurerm_app_service_certificate_binding" {
#   source="../../templates/azurerm/azurerm_app_service_certificate_binding"
#   certificate_id=module.azurerm_app_service_managed_certificate.id
#   hostname_binding_id=module.azurerm_app_service_custom_hostname_binding.id
# }


# module "azurerm_app_service_api" {
#   source="../../templates/azurerm/azurerm_app_service_api"
#   name="${var.resource_group_name}-api"
#   app_service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_app="vantage-core-api"
#   docker_repo=var.docker_repo
# }
# module "azurerm_app_service_api_dns_cname_record" {
#   source="../../templates/azurerm/azurerm_dns_cname_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   prefix="api"
#   resource_group_name=module.azurerm_resource_group.name
#   #record=module.azurerm_app_service_api
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
#   #target_resource_id=module.azurerm_app_service_api.id
#   record=module.azurerm_app_service_api.default_site_hostname
# }
# module "azurerm_app_service_api_custom_dns_txt_record" {
#   source="../../templates/azurerm/azurerm_dns_txt_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   #hostname="admin.${var.resource_group_name}"
#   prefix="api"
#   record=[module.azurerm_app_service.custom_domain_verification_id]
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
# }
# module "azurerm_app_service_api_custom_hostname_binding" {
#   depends_on=[module.azurerm_app_service_api,module.azurerm_resource_group,module.azurerm_app_service_api_custom_dns_txt_record]
#   source="../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_api.name
#   defaultdomain=var.defaultdomain
#   #hostname=module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
#   #hostname=module.azurerm_dns_zone.hostname
#   #hostname="api.${var.hostname}"
#   prefix="api"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module "azurerm_app_service_api_managed_certificate" {
#   source="../../templates/azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_api_custom_hostname_binding.id
# }

# module "azurerm_app_service_admin" {
#   source="../../templates/azurerm/azurerm_app_service"
#   name="${var.resource_group_name}-admin-app"
#   app_service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_app="vantage-admin-app"
#   docker_repo=var.docker_repo
# }
# module "azurerm_app_service_admin_dns_cname_record" {
#   source="../../templates/azurerm/azurerm_dns_cname_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   prefix="admin"
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
#   #target_resource_id=module.azurerm_app_service_admin.id
#   record=module.azurerm_app_service_admin.default_site_hostname
# }
# module "azurerm_app_service_admin_custom_dns_txt_record" {
#   source="../../templates/azurerm/azurerm_dns_txt_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   prefix="admin"
#   record=[module.azurerm_app_service.custom_domain_verification_id]
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
# }
# module "azurerm_app_service_admin_custom_hostname_binding" {
#   depends_on=[module.azurerm_app_service_admin,module.azurerm_resource_group,module.azurerm_app_service_admin_custom_dns_txt_record]
#   source="../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_admin.name
#   defaultdomain=var.defaultdomain
#   #hostname=module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
#   #hostname=module.azurerm_dns_zone.hostname
#   #hostname="admin.${local.hostname}"
#   prefix="admin"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module "azurerm_app_service_admin_managed_certificate" {
#   source="../../templates/azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_admin_custom_hostname_binding.id
# }

# module "azurerm_app_service_admin_api" {
#   source="../../templates/azurerm/azurerm_app_service_api"
#   name="${var.resource_group_name}-admin-api"
#   app_service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_app="vantage-admin-api"
#   docker_repo=var.docker_repo
# }
# module "azurerm_app_service_admin_api_dns_cname_record" {
#   source="../../templates/azurerm/azurerm_dns_cname_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   prefix="adminapi"
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
#   #target_resource_id=module.azurerm_app_service_admin_api.id
#   record=module.azurerm_app_service_admin_api.default_site_hostname
# }
# module "azurerm_app_service_admin_api_custom_dns_txt_record" {
#   source="../../templates/azurerm/azurerm_dns_txt_record"
#   #record={value=module.azurerm_app_service.custom_domain_verification_id}
#   prefix="adminapi"
#   record=[module.azurerm_app_service.custom_domain_verification_id]
#   resource_group_name=module.azurerm_resource_group.name
#   #zone_name=module.azurerm_dns_zone.name
#   zone_name=var.dns_zone_name
#   dns_resource_group_name=var.dns_resource_group_name
# }
# module "azurerm_app_service_admin_api_custom_hostname_binding" {
#   depends_on=[module.azurerm_app_service_admin_api,module.azurerm_resource_group,module.azurerm_app_service_admin_api_custom_dns_txt_record]
#   source="../../templates/azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_admin_api.name
#   defaultdomain=var.defaultdomain
#   #hostname=module.azurerm_dns_zone.hostname # using cloudflare for dns cant use
#   #hostname=module.azurerm_dns_zone.hostname
#   #hostname="adminapi.${var.hostname}"
#   prefix="adminapi"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module "azurerm_app_service_admin_api_managed_certificate" {
#   source="../../templates/azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_admin_api_custom_hostname_binding.id
# }


# module "azurerm_network_security_rule" {
#   #count=length(var.nsg_rules)
#   for_each=var.asgs
#   source="../../templates/azurerm/azurerm_network_security_rule"
#   name=var.nsg_rules[count.index]
#   #name=each.value
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
# }

module "azurerm_storage_account" {
  source              = "../../templates/azurerm/azurerm_storage_account"
  location            = module.azurerm_resource_group.location
  name                = "${module.azurerm_resource_group.name}schedulersa"
  resource_group_name = module.azurerm_resource_group.name
}

module "azurerm_service_plan_functionapp" {
  source              = "../../templates/azurerm/azurerm_service_plan"
  name                = "${module.azurerm_resource_group.name}-fa-asp"
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  sku                 = "Y1"
  #app_service_plan_tier="Dynamic"
  #app_service_plan_size="Y1"
  #kind="FunctionApp"
  os_type  = "Windows"
  reserved = true
}

module "azurerm_virtual_network" {
  source              = "../../templates/azurerm/azurerm_virtual_network"
  name                = var.vnet_name
  subnets             = var.vnet_subnets
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  #address_space=var.address_space
}

module "azurerm_windows_function_app" {
  depends_on           = [module.azurerm_storage_account]
  source               = "../../templates/azurerm/azurerm_windows_function_app"
  name                 = "${module.azurerm_resource_group.name}-fa-asp"
  location             = module.azurerm_resource_group.location
  resource_group_name  = module.azurerm_resource_group.name
  service_plan_id      = module.azurerm_service_plan_functionapp.id
  storage_account_name = module.azurerm_storage_account.name
  #app_service_plan_tier="Dynamic"
  #app_service_plan_size="Y1"
  #kind="FunctionApp"
  #reserved=true
  virtual_network_subnet_id = module.azurerm_virtual_network.id
  #site_config=var.site_config
}