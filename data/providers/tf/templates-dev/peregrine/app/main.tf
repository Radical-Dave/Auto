locals {
  #auth0_org=length(var.AUTH0_ORGANIZATION_ID != null ? var.AUTH0_ORGANIZATION_ID : "")>0 ? var.AUTH0_ORGANIZATION_ID : local.envname == "www" ? module.app_auth0_organization[0].id : data.azurerm_key_vault_secret.auth0_org[0].value
  auth0_org               = var.AUTH0_ORGANIZATION_ID != null ? var.AUTH0_ORGANIZATION_ID : data.azurerm_key_vault_secret.auth0_org[0].value
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
  host                    = length(var.HOST != null ? var.HOST : "") > 0 ? var.HOST : length(local.prefix) > 0 ? (local.prefix != local.host_root ? "${local.envname}.${local.prefix}" : local.envname) : local.resource_group_name
  hostname                = length(var.HOSTNAME != null ? var.HOSTNAME : "") > 0 ? var.HOSTNAME : "${local.host}.${local.dns_domain}"
  host_root               = replace(local.dns_domain, ".com", "")
  name                    = "${local.prefix}-${local.envname}" #length(var.name != null ? var.name : "") > 0 ? var.name : "${local.prefix}-${local.envname}"
  nsg_rules               = coalesce(var.nsg_rules, {})        #length(module.azurerm_application_security_group.id) > 0 ? tomap(object({name=module.azurerm_application_security_group[*].namedestination_application_security_group_ids=module.azurerm_application_security_group[*].id})) : {}
  project_api_key       = length(var.project_API_KEY != null ? var.project_API_KEY : "") > 0 ? var.project_API_KEY : ""
  project_api_audience  = length(var.project_API_AUDIENCE != null ? var.project_API_AUDIENCE : "") > 0 ? var.project_API_AUDIENCE : "https://api.${local.hostname}"
  project_api_authority = length(var.project_API_AUTHORITY != null ? var.project_API_AUTHORITY : "") > 0 ? var.project_API_AUTHORITY : "https://project-dev.us.auth0.com"
  #project_api_auth0_org=length(var.project_API_AUTH0_ORG != null ? var.project_API_AUTH0_ORG : "") > 0 ? var.project_API_AUTH0_ORG : ""
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
# data azurerm_key_vault_secret ad_app {
#   name=var.APP_SP
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
data "azurerm_key_vault_secret" "auth0_org" {
  count        = local.prefix != local.host_root && local.envname != "www" ? 1 : 0
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${replace(local.name, "-test", "-www")}-project-api-auth0-org"
}
#managed identities
# data azurerm_user_assigned_identity assigned_identity_acr_pull {
#  provider=azurerm.acr_sub
#  name=var.docker_username
#  resource_group_name=var.resource_group_name
# }
module "azurerm_resource_group" {
  source   = "../../azurerm/azurerm_resource_group"
  location = var.LOCATION
  name     = local.resource_group_name
}
# module azurerm_application_gateway {
#   source="../../azurerm/azurerm_application_gateway"
#   resource_group_name=module.azurerm_resource_group.name
#   location=module.azurerm_resource_group.location
#   #address_space=local.address_space
#   #subnets=local.subnets
#   address_space=var.ADDRESS_SPACE
#   subnets=var.SUBNETS
# }

module "azurerm_application_security_group" {
  source              = "../../azurerm/azurerm_application_security_group"
  for_each            = toset(var.asgs)
  name                = each.value
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_network_security_group" {
  source = "../../azurerm/azurerm_network_security_group"
  name   = var.nsg_name
  #asgs=module.azurerm_application_security_group.*.id
  nsg_rules           = local.nsg_rules
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}

module "azurerm_virtual_network" {
  source              = "../../azurerm/azurerm_virtual_network"
  name                = var.vnet_name
  subnets             = var.vnet_subnets
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  #address_space=var.ADDRESS_SPACE
}
module "azurerm_subnet" {
  source               = "../../azurerm/azurerm_subnet"
  name                 = var.vnet_name #"AzureFirewallSubnet"
  location             = module.azurerm_resource_group.location
  resource_group_name  = module.azurerm_resource_group.name
  virtual_network_name = module.azurerm_virtual_network.name
  address_prefixes     = local.subnet_address_prefixes
}
module "azurerm_subnet_asg" {
  for_each             = toset(var.asgs)
  source               = "../../azurerm/azurerm_subnet"
  name                 = "${each.value}-subnet"
  location             = module.azurerm_resource_group.location
  resource_group_name  = module.azurerm_resource_group.name
  virtual_network_name = module.azurerm_virtual_network.name
  address_prefixes     = ["10.0.${index(tolist(var.asgs), each.value) + 2}.0/24"]
}
# module azurerm_subnet_api {
#   source="../../azurerm/azurerm_subnet"
#   name="${module.azurerm_resource_group.name}-api-subnet"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name  
#   virtual_network_name=module.azurerm_virtual_network.name
#   address_prefixes=["10.0.2.0/24"]
# }
# module azurerm_subnet_db {
#   source="../../azurerm/azurerm_subnet"
#   name="${module.azurerm_resource_group.name}-db-subnet"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name  
#   virtual_network_name=module.azurerm_virtual_network.name
#   address_prefixes=["10.0.3.0/24"]
# }
# module azurerm_subnet_web {
#   source="../../azurerm/azurerm_subnet"
#   name="${module.azurerm_resource_group.name}-web-subnet"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name  
#   virtual_network_name=module.azurerm_virtual_network.name
#   address_prefixes=["10.0.4.0/24"]
# }
module "azurerm_public_ip" {
  source              = "../../azurerm/azurerm_public_ip"
  name                = var.pip_name
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  #address_prefix=var.address_prefix
}
# module azurerm_public_ip_firewall {
#   source="../../azurerm/azurerm_public_ip"
#   name="${module.azurerm_resource_group.name}-firewall-pip"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name  
#   #address_prefix=var.address_prefix
# }
# module azurerm_firewall {
#   source="../../azurerm/azurerm_firewall"
#   #name=var.firewall_name
#   location=module.azurerm_resource_group.location
#   public_ip_address_id=module.azurerm_public_ip_firewall.id
#   resource_group_name=module.azurerm_resource_group.name
#   subnet_id=module.azurerm_subnet.id
# }
# module azurerm_network_interface {
#   source="../../azurerm/azurerm_network_interface"
#   name=var.pip_name
#   network_security_group_id=[module.azurerm_network_security_group.id]
#   resource_group_name=module.azurerm_resource_group.name
#   location=module.azurerm_resource_group.location
#   #address_prefix=var.address_prefix
#   ip_configuration=[{
#     name="${module.azurerm_public_ip_firewall.name}-ip"
#     private_ip_address_allocation="Dynamic"
#     primary=true
#     #gateway_load_balancer_frontend_ip_configuration_id=module.azurerm_public_ip.id #ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id    
#     private_ip_address="${module.azurerm_public_ip_firewall.id}"    
#     #private_ip_address_version="${module.azurerm_public_ip.private_ip_address_version}" ? "${module.azurerm_public_ip.private_ip_address_version}" : null
#     public_ip_address_id="${module.azurerm_public_ip_firewall.id}"
#     subnet_id=module.azurerm_subnet.id
#     #application_security_group_id="${module.azurerm_application_security_group.id}" 
#   }]
# }
module "azurerm_network_interface" {
  source                    = "../../azurerm/azurerm_network_interface"
  name                      = var.pip_name
  network_security_group_id = [module.azurerm_network_security_group.id]
  resource_group_name       = module.azurerm_resource_group.name
  location                  = module.azurerm_resource_group.location
  #address_prefix=var.address_prefix
  ip_configuration = [{
    name                          = "${module.azurerm_public_ip.name}-ip"
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    #gateway_load_balancer_frontend_ip_configuration_id=module.azurerm_public_ip.id #ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id    
    private_ip_address = "${module.azurerm_public_ip.id}"
    #private_ip_address_version="${module.azurerm_public_ip.private_ip_address_version}" ? "${module.azurerm_public_ip.private_ip_address_version}" : null
    public_ip_address_id = "${module.azurerm_public_ip.id}"
    subnet_id            = module.azurerm_subnet.id
    #application_security_group_id="${module.azurerm_application_security_group.id}" 
  }]
}
# module azurerm_network_interface_application_security_group_association_web {
#   source="../../azurerm/azurerm_network_interface_application_security_group_association"
#   for_each=var.asgs
#   network_interface_id=module.azurerm_network_interface.id
#   application_security_group_id=module.azurerm_application_security_group[each.value].id
# }

# module azurerm_network_interface_application_security_group_association_web {
#   source="../../azurerm/azurerm_network_interface_application_security_group_association"
#   network_interface_id=module.azurerm_network_interface.id
#   application_security_group_id=module.azurerm_application_security_group["~web"].id
# }
# module azurerm_network_interface_application_security_group_association_api {
#   source="../../azurerm/azurerm_network_interface_application_security_group_association"
#   network_interface_id=module.azurerm_network_interface.id
#   application_security_group_id=module.azurerm_application_security_group["~api"].id
# }
# module azurerm_network_interface_security_group_association {
#   source="../../azurerm/azurerm_network_interface_security_group_association"
#   # depends_on=[module.azurerm_network_interface, module.azurerm_network_security_group]  
#   #for_each=toset("${module.azurerm_network_security_group[*].id}")
#   for_each={ for index, value in module.azurerm_network_security_group[*].id : index => value}
#   nic_id=module.azurerm_network_interface.id
#   nsg_id=each.value
# }
# module azurerm_network_interface_application_security_group_association {
#   source="../../azurerm/azurerm_network_interface_application_security_group_association"
#   # depends_on=[module.azurerm_network_interface, module.azurerm_application_security_group]  
#   for_each=toset("${module.azurerm_application_security_group[*].id}")
#   #for_each={ for index, value in module.azurerm_application_security_group[*].id : index => value}
#   nic_id=module.azurerm_network_interface.id
#   asg_id=each.value
# }




# module azurerm_network_interface_application_security_group_association {
#   source="../../azurerm/azurerm_network_interface_application_security_group_association"
#   depends_on=[module.azurerm_network_interface, module.azurerm_application_security_group]
#   #for_each=module.azurerm_application_security_group.*.id
#   #for_each={ for item in module.azurerm_application_security_group.*.id : item => item}  
#   for_each=toset(module.azurerm_application_security_group[*].id)
#     nic_id=module.azurerm_network_interface.id
#     asg_id=each.value
#   #count=length(var.asgs)
#   #  nic_id=module.azurerm_network_interface.id
#   #  asg_id=var.asgs[count.index]
# }
module "azurerm_mssql_server" {
  source               = "../../azurerm/azurerm_mssql_server"
  name                 = var.dbserver_name
  dbserver_version     = var.dbserver_version
  dbserver_login       = var.dbserver_login
  dbserver_pwd         = var.dbserver_pwd
  location             = module.azurerm_resource_group.location
  resource_group_name  = module.azurerm_resource_group.name
  vault_name           = local.vault_name
  vault_resource_group = local.vault_resource_group
}
module "azurerm_storage_account" {
  source              = "../../azurerm/azurerm_storage_account"
  name                = var.sa_name
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_storage_container_logs" {
  depends_on           = [module.azurerm_storage_account]
  source               = "../../azurerm/azurerm_storage_container"
  name                 = "logs"
  storage_account_name = module.azurerm_storage_account.name
}
module "azurerm_storage_container_reports" {
  count                = local.envname == "cd" ? 1 : 0
  depends_on           = [module.azurerm_storage_account]
  source               = "../../azurerm/azurerm_storage_container"
  name                 = "reports"
  storage_account_name = module.azurerm_storage_account.name
}
module "azurerm_storage_container_tests" {
  count                = local.envname == "cd" ? 1 : 0
  depends_on           = [module.azurerm_storage_account]
  source               = "../../azurerm/azurerm_storage_container"
  name                 = "tests"
  storage_account_name = module.azurerm_storage_account.name
}
# module azurerm_mssql_database {
#   depends_on=[module.azurerm_mssql_server]
#   source="../../azurerm/azurerm_mssql_database"
#   connection_string=module.azurerm_mssql_server.connection_string
#   name=var.db_name
#   sa_endpoint=module.azurerm_storage_account.endpoint
#   sa_key=module.azurerm_storage_account.key
#   dbserver_id=module.azurerm_mssql_server.id
#   resource_group_name=module.azurerm_resource_group.name
#   vault_name=local.vault_name
#   vault_resource_group=local.vault_resource_group
# }


data "azurerm_dns_zone" "parent" {
  name                = local.dns_domain
  resource_group_name = local.dns_resource_group_name
}
# module azurerm_dns_zone {
#   source="../../azurerm/azurerm_dns_zone"
#   name=replace(local.hostname,"api.","")
#   resource_group_name=local.resource_group_name
# }
# module azurerm_dns_ns_record {
#   depends_on=[module.azurerm_dns_zone]
#   source="../../azurerm/azurerm_dns_ns_record"
#   name=local.host  
#   records=module.azurerm_dns_zone.name_servers
#   resource_group_name=data.azurerm_dns_zone.parent.resource_group_name
#   ttl=30
#   zone_name=data.azurerm_dns_zone.parent.name  
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


# module azurerm_dns_a_record {
#   source="../../azurerm/azurerm_dns_a_record"
#   name="@"
#   records=[module.azurerm_public_ip.ip_address]
#   resource_group_name=local.resource_group_name
#   ttl=30
#   zone_name=local.hostname
# }
# module azurerm_dns_cname_record {
#   source="../../azurerm/azurerm_dns_a_record"
#   name="www"
#   records=module.azurerm_public_ip.ip_address
#   resource_group_name=local.resource_group_name
#   ttl=30
#   zone_name=local.hostname
# }

# module azurerm_app_service_plan {
#   source="../../azurerm/azurerm_app_service_plan"
#   capacity=3
#   #kind="app,container,linux", #kind="xenon", #kind="app,linux,container"
#   kind="Linux"
#   location=module.azurerm_resource_group.location
#   name=var.app_service_plan_name
#   #os_type="Linux"
#   reserved=true
#   resource_group_name=module.azurerm_resource_group.name  
#   #sku="P1v2"
#   size="P1v2"
#   tier="PremiumV2"  
# }
module "azurerm_service_plan" {
  source              = "../../azurerm/azurerm_service_plan"
  kind                = "Linux" #kind="app,container,linux", #kind="xenon", #kind="app,linux,container"
  location            = module.azurerm_resource_group.location
  name                = "${local.name}-asp"
  os_type             = "Linux"
  reserved            = true
  resource_group_name = module.azurerm_resource_group.name
  #sku_name="P1v2"
  #worker_count=3
  sku = "P1v2"
}

# module azurerm_app_linux_and_api {
#   #depends_on=[module.azurerm_resource_group,module.azurerm_storage_account,module.azurerm_mssql_server,module.azurerm_app_service_plan,module.azurerm_dns_zone,module.azurerm_dns_ns_record]
#   depends_on=[module.azurerm_resource_group,module.azurerm_storage_account,module.azurerm_mssql_server,module.azurerm_service_plan]
#   #depends_on=[module.azurerm_resource_group,module.azurerm_storage_account,module.azurerm_mssql_server,module.azurerm_app_service_plan,module.azurerm_dns_zone]
#   source="../../azurerm/azurerm_app_linux_and_api"
#   api=var.API
#   app=var.APP
#   app_sp=var.APP_SP
#   connection_strings=[{
#     name="VantageDatabase"
#     type="SQLAzure"
#     value="${module.azurerm_mssql_server.connection_string};Initial Catalog=${local.name}-db;"
#   }]  
#   #db=module.azurerm_mssql_server.connection_string
#   dns_domain=local.dns_domain
#   dns_resource_group_name=local.dns_resource_group_name
#   docker_image_tag=local.docker_image_tag
#   docker_password=local.docker_password
#   docker_registry=local.docker_registry
#   docker_username=local.docker_username
#   #ext=local.ext
#   host=local.host
#   hostname=local.hostname
#   host_root=local.host_root
#   location=module.azurerm_resource_group.location
#   log_sas_url=module.azurerm_storage_account.primary_connection_string
#   name="${local.prefix}-${local.envname}"
#   project_api_key=local.project_api_key
#   project_api_audience=local.project_api_audience
#   project_api_authority=local.project_api_authority
#   project_api_auth0_org=local.auth0_org
#   project_api_client_id=local.project_api_client_id
#   project_api_client_secret=local.project_api_client_secret
#   project_api_origins=local.project_api_origins
#   resource_group_name=module.azurerm_resource_group.name
#   service_plan_id=module.azurerm_service_plan.id
#   #settings=local.settings
#   #settings_api=merge(local.settings,local.settings_api)
#   #settings_app=merge(local.settings,local.settings_app)
#   zone_name=local.zone_name
# }


module "azurerm_app_and_api" {
  #depends_on=[module.azurerm_resource_group,module.azurerm_storage_account,module.azurerm_mssql_server,module.azurerm_app_service_plan,module.azurerm_dns_zone,module.azurerm_dns_ns_record]
  depends_on = [module.azurerm_resource_group, module.azurerm_storage_account, module.azurerm_mssql_server, module.azurerm_service_plan]
  #depends_on=[module.azurerm_resource_group,module.azurerm_storage_account,module.azurerm_mssql_server,module.azurerm_app_service_plan,module.azurerm_dns_zone]
  source = "../../azurerm/azurerm_app_and_api"
  api    = var.API
  app    = var.APP
  app_sp = var.APP_SP
  connection_strings = [{
    name  = "VantageDatabase"
    type  = "SQLAzure"
    value = "${module.azurerm_mssql_server.connection_string};Initial Catalog=${local.name}-db;"
  }]
  #db=module.azurerm_mssql_server.connection_string
  dns_domain              = local.dns_domain
  dns_resource_group_name = local.dns_resource_group_name
  #docker_image_tag=local.docker_image_tag
  #docker_password=local.docker_password
  #docker_registry=local.docker_registry
  #docker_username=local.docker_username
  #ext=local.ext
  host                        = local.host
  hostname                    = local.hostname
  host_root                   = local.host_root
  location                    = module.azurerm_resource_group.location
  log_sas_url                 = module.azurerm_storage_account.primary_connection_string
  name                        = "${local.prefix}-${local.envname}"
  project_api_key           = local.project_api_key
  project_api_audience      = local.project_api_audience
  project_api_authority     = local.project_api_authority
  project_api_auth0_org     = local.auth0_org
  project_api_client_id     = local.project_api_client_id
  project_api_client_secret = local.project_api_client_secret
  project_api_origins       = local.project_api_origins
  resource_group_name         = module.azurerm_resource_group.name
  service_plan_id             = module.azurerm_service_plan.id
  #settings=local.settings
  #settings_api=merge(local.settings,local.settings_api)
  #settings_app=merge(local.settings,local.settings_app)
  zone_name = local.zone_name
}

# module azurerm_app_and_api {
#   source="../../azurerm/azurerm_app_and_api"
#   app="vantage-admin-app"
#   api="vantage-admin-api"
#   app_sp=var.APP_SP
#   connection_strings=[{
#     name="VantageDatabase"
#     type="SqlAzure"
#     value=module.azurerm_mssql_server.connection_string
#   }]
#   #envname=local.envname
#   dns_domain=local.dns_domain
#   dns_resource_group_name=local.dns_resource_group_name
#   docker_password=local.docker_password
#   docker_registry=local.docker_registry
#   docker_username=local.docker_username
#   domain=local.dns_domain
#   host="admin.${local.host}"
#   hostname="admin.${local.hostname}"
#   location=module.azurerm_resource_group.location
#   name="${local.prefix}-${local.envname}-admin"
#   #prefix=local.prefix
#   project_api_key=local.project_api_key
#   project_api_audience="https://api.admin.${local.hostname}"
#   project_api_authority=local.project_api_authority
#   project_api_auth0_org=local.auth0_org
#   project_api_client_id=local.project_admin_api_client_id
#   project_api_client_secret=local.project_admin_api_client_secret
#   resource_group_name=module.azurerm_resource_group.name
#   service_plan_id=module.azurerm_app_service_plan.id
#   zone_name=local.zone_name
# }


# module azurerm_key_vault_certificate {
#   source="../../azurerm/azurerm_key_vault_certificate"  
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name=var.appserviceplan_name
#   resource_group_name=module.azurerm_resource_group.name
# }
# TODO: Doesnt exist yet
# data azurerm_key_vault_secret app_ssl {
##   name="${var.resource_group_name}-kvs"
#   name="${module.azurerm_resource_group.name}-kvs"
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
# module azurerm_app_service_certificate {
#   source="../../azurerm/azurerm_app_service_certificate"
#   app_service_plan_id=module.azurerm_app_service_plan.id
#service_plan_id=module.azurerm_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   #key_vault_secret_id=module.azurerm_key_vault_certificate.secret_id
#   #key_vault_secret_id=data.azurerm_key_vault_secret.app_ssl.id
# }





# module azurerm_dns_zone {
#   source="../../azurerm/azurerm_dns_zone"
#   name=local.hostname
# }

# module azurerm_linux_web_app {
#   source="../../azurerm/azurerm_linux_web_app"
#   #service_plan_id=module.azurerm_service_plan.id
#   service_plan_id=module.azurerm_app_service_plan.id  
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   kind="app,linux,container"
#   docker_image="vantage-ng-app"
#   docker_registry=local.docker_registry
#   # site_config={
#   #   scm_type="GIT"
#   #   always_on="true"
#   #   linux_fx_version="DOCKER|${var.dockerrepo}/vantage-ng-app:latest"
#   #   health_check_path="/health"
#   # }
#   tags=var.tags
# }

# module azurerm_dns_cname_record {
#   source="../../azurerm/azurerm_dns_cname_record"
#   name=local.host
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
#   #target_resource_id=module.azurerm_app_service.id
#   record=module.azurerm_linux_web_app.default_hostname
# }
# module azurerm_dns_txt_record {
#   source="../../azurerm/azurerm_dns_txt_record"
#   name=local.host
#   record=[{value=module.azurerm_linux_web_app.custom_domain_verification_id}]
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
# }

# module azurerm_app_service_custom_hostname_binding {
#   depends_on=[module.azurerm_linux_web_app,module.azurerm_resource_group,module.azurerm_dns_txt_record]
#   source="../../azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_linux_web_app.name
#   hostname=local.hostname
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_managed_certificate {
#   source="../../azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_custom_hostname_binding.id
# }
# module azurerm_app_service_certificate_binding {
#   source="../../azurerm/azurerm_app_service_certificate_binding"
#   certificate_id=module.azurerm_app_service_managed_certificate.id
#   hostname_binding_id=module.azurerm_app_service_custom_hostname_binding.id
# }


# module azurerm_app_service_api {
#   source="../../azurerm/azurerm_app_service_api"
#   name="${module.azurerm_resource_group.name}-api"
#   #app_service_plan_id=module.azurerm_app_service_plan.id
#   service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_image="vantage-core-api"
#   docker_registry=local.docker_registry
# }
# module azurerm_app_service_api_dns_cname_record {
#   source="../../azurerm/azurerm_dns_cname_record"
#   name="api.${local.hostname}"
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
#   #target_resource_id=module.azurerm_app_service_api.id
#   record=module.azurerm_app_service_api.default_site_hostname
# }
# module azurerm_app_service_api_custom_dns_txt_record {
#   source="../../azurerm/azurerm_dns_txt_record"
#   name="api.${local.host}"
#   record=[{value=module.azurerm_app_service_api.custom_domain_verification_id}]
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_api_custom_hostname_binding {
#   depends_on=[module.azurerm_app_service_api,module.azurerm_resource_group,module.azurerm_app_service_api_custom_dns_txt_record]
#   source="../../azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_api.name
#   hostname="api.${local.hostname}"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_api_managed_certificate {
#   source="../../azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_api_custom_hostname_binding.id
# }







# module azurerm_app_service_admin {
#   source="../../azurerm/azurerm_app_service"
#   name="${module.azurerm_resource_group.name}-admin-app"
#   #app_service_plan_id=module.azurerm_app_service_plan.id
#   service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_image="vantage-admin-app"
#   docker_registry=local.docker_registry
# }
# module azurerm_app_service_admin_dns_cname_record {
#   source="../../azurerm/azurerm_dns_cname_record"
#   name="admin.${local.host}"
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
#   #target_resource_id=module.azurerm_app_service_admin.id
#   record=module.azurerm_app_service_admin.default_site_hostname
# }
# module azurerm_app_service_admin_custom_dns_txt_record {
#   source="../../azurerm/azurerm_dns_txt_record"
#   name="admin.${local.host}"
#   record=[{value=module.azurerm_app_service_admin.custom_domain_verification_id}]
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_admin_custom_hostname_binding {
#   depends_on=[module.azurerm_app_service_admin,module.azurerm_resource_group,module.azurerm_app_service_admin_custom_dns_txt_record]
#   source="../../azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_admin.name
#   hostname="admin.${local.hostname}"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_admin_managed_certificate {
#   source="../../azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_admin_custom_hostname_binding.id
# }

# module azurerm_app_service_admin_api {
#   source="../../azurerm/azurerm_app_service_api"
#   name="${module.azurerm_resource_group.name}-admin-api"
#   #app_service_plan_id=module.azurerm_app_service_plan.id
#   service_plan_id=module.azurerm_app_service_plan.id
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   docker_image="vantage-admin-api"
#   docker_registry=local.docker_registry
# }
# module azurerm_app_service_admin_api_dns_cname_record {
#   source="../../azurerm/azurerm_dns_cname_record"
#   name="adminapi.${local.host}"
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
#   #target_resource_id=module.azurerm_app_service_admin_api.id
#   record=module.azurerm_app_service_admin_api.default_site_hostname
# }
# module azurerm_app_service_admin_api_custom_dns_txt_record {
#   source="../../azurerm/azurerm_dns_txt_record"
#   name="adminapi.${local.host}"
#   record=[{value=module.azurerm_app_service_admin_api.custom_domain_verification_id}]
#   resource_group_name=module.azurerm_resource_group.name
#   zone_name=module.azurerm_dns_zone.name
#   #zone_name=local.zone_name
#   #dns_resource_group_name=local.dns_resource_group_name
#   dns_resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_admin_api_custom_hostname_binding {
#   depends_on=[module.azurerm_app_service_admin_api,module.azurerm_resource_group,module.azurerm_app_service_admin_api_custom_dns_txt_record]
#   source="../../azurerm/azurerm_app_service_custom_hostname_binding"
#   app_service_name=module.azurerm_app_service_admin_api.name
#   hostname="adminapi.${local.hostname}"
#   #join(".", [azurerm_dns_cname_record.example.name, azurerm_dns_cname_record.example.zone_name])
#   resource_group_name=module.azurerm_resource_group.name
# }
# module azurerm_app_service_admin_api_managed_certificate {
#   source="../../azurerm/azurerm_app_service_managed_certificate"
#   custom_hostname_binding_id=module.azurerm_app_service_admin_api_custom_hostname_binding.id
# }





# module azurerm_network_security_rule {
#   depends_on=[module.azurerm_resource_group,azurerm_network_security_group]
#   source="../../azurerm/azurerm_network_security_rule"
#   #count=length(var.nsg_rules)  
#   #name=var.asgs[count.index]
#   #name=each.value
#   for_each=var.asgs
#   name=each.value
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   network_security_group_name=module.azurerm_resource_group.name
# }





# module azurerm_storage_account {
#   source="../../azurerm/azurerm_storage_account"
#   location=module.azurerm_resource_group.location
#   name="${module.azurerm_resource_group.name}schedulersa"
#   resource_group_name=module.azurerm_resource_group.name  
# }

# module azurerm_service_plan_functionapp {
#   source="../../azurerm/azurerm_service_plan"
#   name="${module.azurerm_resource_group.name}-fa-asp"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
#   sku="Y1"
#   #app_service_plan_tier="Dynamic"
#   #app_service_plan_size="Y1"
#   #kind="FunctionApp"
#   os_type="Windows"
#   reserved=true
# }

# module azurerm_virtual_network {
#   source="../../azurerm/azurerm_virtual_network"
#   name=var.vnet_name
#   subnets=var.vnet_subnets
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name  
#   #address_space=var.ADDRESS_SPACE
# }
module "azurerm_service_plan_windows" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../templates/azurerm/azurerm_service_plan"
  #kind="Linux"#kind="app,container,linux", #kind="xenon", #kind="app,linux,container"
  location            = module.azurerm_resource_group.location
  name                = "${local.name}-asp-windows"
  os_type             = "Windows"
  reserved            = true
  resource_group_name = module.azurerm_resource_group.name
  #sku_name="P1v2"
  #worker_count=3
  sku = "P1v2"
}
module "azurerm_windows_function_app" {
  depends_on          = [module.azurerm_resource_group]
  source              = "../../templates/azurerm/azurerm_windows_function_app"
  name                = "${local.name}-sched-func"
  location            = module.azurerm_resource_group.location
  resource_group_name = module.azurerm_resource_group.name
  service_plan_id     = module.azurerm_service_plan_windows.id
  #site_config=var.site_config
  site_config = {
    app_settings = {
      "JOB_FUNCTION_BASE_URL"       = "https://${module.azurerm_resource_group.name}-sched-func.azurewebsites.net/api/JobRunner?code=idb6kifyVaaixImTe4tQO4g3O/Tje/veP/boiUi4Z5h3vkC33bjR6A=="
      "project_API_AUDIENCE"      = local.project_api_audience
      "project_API_CLIENT_ID"     = local.project_api_client_id
      "project_API_CLIENT_SECRET" = local.project_api_client_secret
      "project_BASE_URL"          = local.project_api_audience
      "SCHEDULER_TIMER_TRIGGER"     = "0 */10 * * * *"
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
  virtual_network_subnet_id = module.azurerm_virtual_network.id
}
# resource azurerm_app_service_source_control" "sched-func" {
#   app_id=module.azurerm_windows_function_app.id
#   repo_url=var.FUNCTION_APP_REPO
#   branch="master"
# }

# resource azurerm_management_group" "root" {
#   display_name=module.azurerm_resource_group.name
#   subscription_ids=[data.azurerm_subscription.current.subscription_id]
# }

# resource azurerm_role_definition" "role_assignment_contributor" {
#   name="${module.azurerm_resource_group.name} Owners"
#   scope=azurerm_management_group.root.id
#   description="A role designed for writing and deleting role assignments"    
#   permissions {
#     actions=[
#           "Microsoft.Authorization/roleAssignments/write",
#           "Microsoft.Authorization/roleAssignments/delete",
#     ]
#     not_actions = []
#   }    
#   assignable_scopes = [
#     azurerm_management_group.root.id
#   ]
# }


# data azurerm_role_definition owner {
#   name = "Owner"
# }
# resource azurerm_role_assignment" "root_azdevops" {
#   #depends_on=[azurerm_role_definition.role_assignment_contributor]
#   #scope=azurerm_management_group.root.id
#   scope=data.azurerm_subscription.current.id
#   #role_definition_name="Reader"
#   role_definition_id=data.azurerm_role_definition.owner.id
#   principal_id=data.azurerm_client_config.current.object_id
# }

# module azurerm_app_configuration {
#   source="../../azurerm/azurerm_app_configuration"
#   location=module.azurerm_resource_group.location
#   resource_group_name=module.azurerm_resource_group.name
# }

# data azurerm_app_configuration base {
#   name="projectac" #local.vault_name
#   resource_group_name="base-terraform-rg" #local.vault_resource_group
# }
# resource azurerm_app_configuration_key" "env_connstr" {
#   depends_on=[data.azurerm_app_configuration.base]
#   configuration_store_id=data.azurerm_app_configuration.base.id
#   key=local.hostname #"${module.azurerm_resource_group.name}:project_api_key"
#   label=local.hostname
#   #label="${module.azurerm_resource_group.name}-project-api-key"
#   value=module.azurerm_app_configuration.primary_read_key[0].connection_string
# }
# resource azurerm_role_assignment" "appconfig_dataowner" {
#   #depends_on=[azurerm_role_assignment.root_azdevops]
#   #source="../../azurerm/azurerm_role_assignment"
#   scope=module.azurerm_app_configuration.id
#   role_definition_name="App Configuration Data Owner"
#   principal_id=data.azurerm_client_config.current.object_id
# }

# module api_key_kv_key {
#   source="../../azurerm/azurerm_key_vault_secret"
#   count=lookup(local.project_api_key,"project_API_KEY",null) == null ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-key"
#   value=lookup(local.ext,"project_API_KEY",null)
# }
resource "azurerm_key_vault_secret" "api_key_kv_key" {
  count        = local.project_api_key == null ? 0 : 1
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-key"
  value        = local.project_api_key
}

# resource azurerm_app_configuration_key" "api_key_id_ac" {
#   depends_on=[azurerm_role_assignment.appconfig_dataowner]
#   configuration_store_id=module.azurerm_app_configuration.id
#   key="project_api_key"
#   label="${module.azurerm_resource_group.name}-project-api-key"
#   vault_key_reference=azurerm_key_vault_secret.api_key_kv_key.id
# }
# module api_audience_kv_key {
#   source="../../azurerm/azurerm_key_vault_secret"
#   count=lookup(local.ext,"project_API_AUDIENCE","https://api.${local.hostname}") == null ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-audience"
#   value=lookup(local.ext,"project_API_AUDIENCE","https://api.${local.hostname}")  
# }
resource "azurerm_key_vault_secret" "api_audience_kv_key" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-audience"
  value        = local.project_api_audience
}
# resource azurerm_app_configuration_key" "api_audience_id_ac"  {
#   depends_on=[azurerm_role_assignment.appconfig_dataowner]
#   configuration_store_id=module.azurerm_app_configuration.id
#   key="project_api_audience"
#   label="${module.azurerm_resource_group.name}-project-api-audience"
#   vault_key_reference=azurerm_key_vault_secret.api_audience_kv_key.id
# }

# module api_authority_kv_key {
#   source="../../azurerm/azurerm_key_vault_secret"
#   count=lookup(local.ext,"project_API_AUTHORITY",null) == null ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-authority"
#   value=lookup(local.ext,"project_API_AUTHORITY",null)  
# }
resource "azurerm_key_vault_secret" "api_authority_kv_key" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-authority"
  value        = local.project_api_authority
}
# resource azurerm_app_configuration_key" "api_authority_id_ac" {
#   depends_on=[azurerm_role_assignment.appconfig_dataowner]
#   configuration_store_id=module.azurerm_app_configuration.id
#   key="project_api_authority"
#   label="${module.azurerm_resource_group.name}-project-api-authority"
#   vault_key_reference=azurerm_key_vault_secret.api_authority_kv_key.id
# }


# module api_auth0_org_kv_key {
#   source="../../azurerm/azurerm_key_vault_secret"
#   count=lookup(local.ext,"project_API_AUTH0_ORG",null) == null ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-auth0-org"
#   value=lookup(local.ext,"project_API_AUTH0_ORG",null)  
# }
resource "azurerm_key_vault_secret" "api_auth0_org_kv_key" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-auth0-org"
  value        = local.auth0_org
}

# resource azurerm_key_vault_secret" "api_client_id_kv_key" {
#   name="${local.name}-project-api-client-id"
#   #value="4WapikZEGNhaUXvKaqFM2VvDIgBVF1M5"#dev-old
#   #value="xBK7BLrYkxP0u46KV5LypJm0mZwJeIc2"#smoke-dev
#   #value="yn7Ha6fHkh07scViqDz39Y8MRqT0bK8A"#smoke-test
#   value=local.project_api_client_id
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
# resource azurerm_app_configuration_key" "api_client_id_ac" {
#   depends_on=[azurerm_role_assignment.appconfig_dataowner]
#   configuration_store_id=module.azurerm_app_configuration.id
#   key="project_api_client_id"
#   label="${module.azurerm_resource_group.name}-project-api-client_id"
#   vault_key_reference=azurerm_key_vault_secret.api_client_id_kv_key.id
# }

# resource azurerm_key_vault_secret" "api_client_secret_kv_key" {
#   name="${local.name}-project-api-client-secret"
#   #value="3e0UXs0eAFurSaB-Gj2b3xKQszQqbc6d2hVWTHAQ2OMqyqLQMR222whq50j31Q_j"#dev-old
#   #value="pKPXKoyZrjNHAQGlsYzVKi94hci6_3lnwx0Oazuq-adXKdxgBumWwtyF8Ukl6cre"
#   value=local.project_api_client_secret
#   key_vault_id=data.azurerm_key_vault.kv.id
# }
# resource azurerm_app_configuration_key" "api_client_secret_ac" {
#   depends_on=[azurerm_role_assignment.appconfig_dataowner]
#   configuration_store_id=module.azurerm_app_configuration.id
#   key="project_api_client_secret"
#   label="${module.azurerm_resource_group.name}-project-api-client-secret"
#   vault_key_reference=azurerm_key_vault_secret.api_client_secret_kv_key.id
#   # value=""  
# }

# module api_origins_kv_key {
#   source="../../azurerm/azurerm_key_vault_secret"
#   count=lookup(local.ext,"project_API_ORIGINS",local.urls) == null ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-origins"
#   value=lookup(local.ext,"project_API_ORIGINS",local.urls)
# }
resource "azurerm_key_vault_secret" "api_origins_kv_key" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-origins"
  value        = local.project_api_origins
}

module "app_auth0_client" {
  source               = "../../templates/auth0/auth0_client"
  allowed_logout_urls  = local.urls_list
  allowed_origins      = local.urls_list
  app_type             = "spa"
  callbacks            = local.urls_list
  cross_origin_auth    = false
  custom_login_page_on = true
  description          = module.azurerm_resource_group.name
  grant_types          = ["authorization_code", "implicit", "refresh_token"]
  #idle_token_lifetime="72000"
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = false
  logo_uri                            = "https://vantagestaticassets.blob.core.windows.net/static/150px-Peregine-app-tile.svg"
  name                                = module.azurerm_resource_group.name
  oidc_conformant                     = true
  token_endpoint_auth_method          = "none"
  #token_lifetime="86400"
  web_origins = local.urls_list
}
module "app_auth0_resource_server" {
  source                                          = "../../templates/auth0/auth0_resource_server"
  allow_offline_access                            = false
  enforce_policies                                = true
  identifier                                      = "https://api.${local.hostname}"
  name                                            = "${module.azurerm_resource_group.name}-api"
  scopes                                          = local.scopes
  skip_consent_for_verifiable_first_party_clients = true
  token_dialect                                   = "access_token_authz"
  token_lifetime                                  = "2592000"
  token_lifetime_for_web                          = "7200"
}
module "app_auth0_resource_server_client_grant" {
  source    = "../../templates/auth0/auth0_client_grant"
  client_id = module.app_auth0_client.client_id
  audience  = module.app_auth0_resource_server.identifier
}
# module app_job_scheduler_auth0_resource_server_client_grant {
#   source="../../auth0/auth0_client_grant"
#   client_id=module.app_auth0_client.client_id
#   audience="jPMFPktqeoqhCG83f3zrblFns1FfIhdN"
# }

# module api_client_id_kv_key {
#   depends_on=[module.app_auth0_client]
#   source="../../azurerm/azurerm_key_vault_secret"
#   #count="${module.app_auth0_client.client_id}" == "" ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-client-id"
#   value=coalesce(module.app_auth0_client.client_id,lookup(local.ext,"project_API_KEY",null))
# }

# module api_client_secret_kv_key {
#   depends_on=[module.app_auth0_client]
#   source="../../azurerm/azurerm_key_vault_secret"
#   #count="${module.app_auth0_client.client_secret}" == "" ? 0 : 1
#   key_vault_id=data.azurerm_key_vault.kv.id
#   name="${local.name}-project-api-client-secret"
#   value=coalesce(module.app_auth0_client.client_secret,lookup(local.ext,"project_API_KEY",null))
# }


module "api_client_id_kv_key" {
  depends_on = [module.app_auth0_client]
  source     = "../../templates/azurerm/azurerm_key_vault_secret"
  #count="${module.app_auth0_client.client_id}" == "" ? 0 : 1
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-client-id"
  value        = module.app_auth0_client.client_id
}

module "api_client_secret_kv_key" {
  depends_on = [module.app_auth0_client]
  source     = "../../templates/azurerm/azurerm_key_vault_secret"
  #count="${module.app_auth0_client.client_secret}" == "" ? 0 : 1
  key_vault_id = data.azurerm_key_vault.kv.id
  name         = "${local.name}-project-api-client-secret"
  value        = module.app_auth0_client.client_secret
}

# module auth0_role {
#   count=local.envname == "www" ? 1 : 0
#   depends_on=[module.app_auth0_resource_server]
#   source="../../templates/auth0/auth0_role"
#   name="${local.prefix}-roles"
#   role="read:roles"
#   resource_server_id=module.app_auth0_resource_server.id
# }
# module app_auth0_resource_server_client_grant {  
#   depends_on=[module.app_auth0_client,module.app_auth0_resource_server]
#   source="../../templates/auth0/auth0_client_grant"
#   client_id=module.app_auth0_client.client_id
#   audience=module.app_auth0_resource_server.identifier
# }