# module auth0_organization {
#   source="../../templates/auth0/auth0_organization"
#   name="azdotemptest"#project-dev
#   display_name="azdotemptest"#project Devs
#   logo_url="https://vantagestaticassets.blob.core.windows.net/static/150px-Peregine-app-tile.svg"
#   colors_primary="#EDEDED"
#   colors_background="#18A0FB"
#   connection_id="con_9OPGKkzu3TroIuzE"
# }
locals {
  adminurls     = ["https://admin.${local.name}.${local.defaultdomain}", "https://api.admin.${local.name}.${local.defaultdomain}", "https://${local.prefix}-${local.name}-admin-app.azurewebsites.net", "https://${local.prefix}-${local.name}-admin-api.azurewebsites.net"]
  defaultdomain = "${local.prefix}.com"
  envname       = length(var.ENVNAME != null ? var.ENVNAME : "") > 0 ? var.ENVNAME : "auth0test"
  name          = "${local.prefix}-${local.envname}" #length(var.name != null ? var.name : "") > 0 ? var.name : "${local.prefix}-${local.envname}"
  prefix        = length(var.PREFIX != null ? var.PREFIX : "") > 0 ? var.PREFIX : "project"
  scopes = [
    { description = "Read all accounts", value = "accounts:read" },
    { description = "Create and edit users", value = "users:manage" },
    { description = "Update roles", value = "update:roles" },
    { description = "Create role members", value = "create:role_members" },
    { description = "Read all roles", value = "read:roles" },
    { description = "Create a role", value = "create:roles" },
    { description = "Read permissions", value = "read:role_member" },
    { description = "Read client permissions", value = "read:role_client_grants" }
  ]
  urls = length(var.URLS != null ? var.URLS : "") > 0 ? var.URLS : "https://${local.name}.${local.defaultdomain},https://api.${local.name}.${local.defaultdomain},https://${local.prefix}-${local.name}-app.azurewebsites.net,https://${local.prefix}-${local.name}-api.azurewebsites.net"
  #urls=["https://${local.name}.${local.defaultdomain}", "https://api.${local.name}.${local.defaultdomain}", "https://${local.prefix}-${local.name}-app.azurewebsites.net", "https://${local.prefix}-${local.name}-api.azurewebsites.net"]
  #urls=length(var.URLS != null ? var.URLS : "") > 0 ? var.URLS : "https://${local.hostname},https://api.${local.hostname},https://${local.name}-app.${local.dns_domain_azure},https://${local.name}-api.${local.dns_domain_azure}${replace(length(regexall("www..*", local.name)) > 0 ? ",https://${local.hostname},https://api.${local.hostname}" : "","www.","")}${local.resource_group_name != "dev" ? "" : ",http://localhost:3000,http://localhost:4200"}"
  urls_list = tolist(split(",", local.urls))
}
module "app_auth0_connection" {
  source = "../../templates/auth0/auth0_connection"
  name   = "${local.envname}-users"
}
module "app_auth0_organization" {
  source            = "../../templates/auth0/auth0_organization"
  colors_primary    = length(var.AUTH0_ORGANIZATION_COLOR_PRIMARY != null ? var.AUTH0_ORGANIZATION_COLOR_PRIMARY : "") > 0 ? var.AUTH0_ORGANIZATION_COLOR_PRIMARY : ""
  colors_background = length(var.AUTH0_ORGANIZATION_COLOR_BACKGROUND != null ? var.AUTH0_ORGANIZATION_COLOR_BACKGROUND : "") > 0 ? var.AUTH0_ORGANIZATION_COLOR_BACKGROUND : ""
  display_name      = length(var.AUTH0_ORGANIZATION_NAME != null ? var.AUTH0_ORGANIZATION_NAME : "") > 0 ? var.AUTH0_ORGANIZATION_NAME : local.prefix
  logo_url          = length(var.AUTH0_ORGANIZATION_LOGO != null ? var.AUTH0_ORGANIZATION_LOGO : "") > 0 ? var.AUTH0_ORGANIZATION_LOGO : ""
  name              = local.envname
  #connection_id=module.app_auth0_connection[0].id
}
resource "auth0_organization_connection" "app_auth0_organization_connection" {
  depends_on                 = [module.app_auth0_connection, module.app_auth0_organization]
  assign_membership_on_login = true
  connection_id              = module.app_auth0_connection.id
  organization_id            = module.app_auth0_organization.id
}
module "app_auth0_client" {
  source               = "../../templates/auth0/auth0_client"
  allowed_logout_urls  = local.urls_list
  allowed_origins      = local.urls_list
  app_type             = "spa"
  logo_uri             = "https://vantagestaticassets.blob.core.windows.net/static/150px-Peregine-app-tile.svg"
  callbacks            = local.urls_list
  cross_origin_auth    = false
  custom_login_page_on = true
  description          = "TESTING - Continuous Deployment - cd.project.com automated test environment"
  grant_types          = ["authorization_code", "implicit", "refresh_token"]
  #idle_token_lifetime="72000"
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = false
  name                                = "azdo-test-${local.name}"
  oidc_conformant                     = true
  token_endpoint_auth_method          = "none"
  #token_lifetime="86400"
  web_origins = local.urls_list
}
module "app_auth0_resource_server" {
  source                                          = "../../templates/auth0/auth0_resource_server"
  allow_offline_access                            = false
  enforce_policies                                = true
  identifier                                      = "api.${local.name}.${local.defaultdomain}"
  name                                            = "azdo-test-${local.name}-api"
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
#   source="../../templates/auth0/auth0_client_grant"
#   client_id=module.app_auth0_client.client_id
#   audience="jPMFPktqeoqhCG83f3zrblFns1FfIhdN"
# }

#admin
module "admin_auth0_client" {
  source               = "../../templates/auth0/auth0_client"
  allowed_logout_urls  = local.adminurls
  allowed_origins      = local.adminurls
  app_type             = "spa"
  callbacks            = local.adminurls
  cross_origin_auth    = false
  custom_login_page_on = false
  description          = "TESTING - Continuous Deployment - cd.project.com automated test environment"
  grant_types          = ["authorization_code", "implicit", "refresh_token"]
  #idle_token_lifetime="72000"
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = false
  logo_uri                            = "https://vantagestaticassets.blob.core.windows.net/static/150px-Peregine-app-tile.svg"
  name                                = "azdo-test-${local.name}-admin"
  oidc_conformant                     = true
  token_endpoint_auth_method          = "none"
  #token_lifetime="86400"
  web_origins = local.adminurls
}
module "app_auth0_job_scheduler" {
  source               = "../../templates/auth0/auth0_client"
  allowed_logout_urls  = local.urls_list
  allowed_origins      = local.urls_list
  app_type             = "non_interactive"
  callbacks            = local.urls_list
  cross_origin_auth    = false
  custom_login_page_on = true
  #depends_on=[module.azurerm_resource_group]
  description = local.name
  grant_types = ["authorization_code", "implicit", "refresh_token"]
  #idle_token_lifetime="72000"
  is_first_party                      = true
  is_token_endpoint_ip_header_trusted = false
  logo_uri                            = "https://vantagestaticassets.blob.core.windows.net/static/150px-Peregine-app-tile.svg"
  name                                = "${local.name}-job-scheduler"
  oidc_conformant                     = true
  token_endpoint_auth_method          = "none"
  #token_lifetime="86400"
  web_origins = local.urls_list
}

module "admin_auth0_resource_server" {
  source                                          = "../../templates/auth0/auth0_resource_server"
  allow_offline_access                            = false
  enforce_policies                                = true
  identifier                                      = "api.admin.${local.name}.${local.defaultdomain}"
  name                                            = "azdo-test-${local.name}-admin-api"
  scopes                                          = local.scopes
  skip_consent_for_verifiable_first_party_clients = true
  token_dialect                                   = "access_token_authz"
  token_lifetime                                  = "2592000"
  token_lifetime_for_web                          = "7200"
}
# module admin_auth0_resource_server_client_grant {
#   source="../../templates/auth0/auth0_client_grant"
#   client_id=module.admin_auth0_client.client_id
#   audience=module.admin_auth0_resource_server.identifier
# }
# module admin_job_scheduler_auth0_resource_server_client_grant {
#   source="../../templates/auth0/auth0_client_grant"
#   client_id=module.admin_auth0_client.client_id
#   audience="jPMFPktqeoqhCG83f3zrblFns1FfIhdN"
# }
