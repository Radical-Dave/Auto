#data "azurerm_client_config" "current" {}
#data "azuredevops_client_config" "current" {}
locals {
  #name = length(var.name) > 0 ? var.name : "peregrine" # appName? #"${var.resource_group_name}-kvk"
  #vault_name = length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  #vault_resource_group = length(var.vault_resource_group) > 0 ? var.vault_resource_group : length(var.resource_group_name) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
  #azdo_personal_access_token = length(var.azdo_personal_access_token != null ? var.azdo_personal_access_token : "") > 0 ? var.azdo_personal_access_token : ""
}



# data "azurerm_key_vault" "key_vault" {
#   name = local.vault_name
#   resource_group_name = local.vault_resource_group
# }
# data "azurerm_key_vault_secret" "ad_app" {
#   name = var.app_sp
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }





# data "external" "app_sp" {
#   program = [
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     "echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#   ]
# }

# module "azurerm_resource_group" {
#   source = "../../templates/azurerm/azurerm_resource_group"
#   resource_group_name = var.resource_group_name
#   location = var.location
# }

module "azuread_application" {
  source = "../../templates/azuread/azuread_application"
  name = var.azdo_project
  #resource_group_name = "core-devops" #var.resource_group_name
  #location = var.location
}
# module "azuread_application_federated_identity_credential" {
#   source = "../../templates/azuread/azuread_application_federated_identity_credential"
#   application_object_id = module.azuread_application.object_id
#   display_name = var.azdo_project
#   audiences = ["api://AzureADTokenExchange"]
#   issuer = "https://token.actions.githubusercontent.com"
#   #resource_group_name = "core-devops" #var.resource_group_name
#   subject = "repo:my-organization/my-repo:environment:prod"  
# }


# module "azuredevops_project" {
#   source = "../../templates/azuredevops/azuredevops_project"
#   name = var.azdo_project
#   resource_group_name = "core-devops" #var.resource_group_name
#   location = var.location
#   description = "ImaginePeregrine is a new, off the shelf and less complex medical billing product for smaller facilities and specialists"
# }
#dependson module.azuread_application
# module "azuredevops_servicehook_permissions" {
#   source = "../../templates/azuredevops/azuredevops_servicehook_permissions"
#   project_id = module.azuredevops_project.id
#   principal = module.azuread_application.object_id
#   permissions = {
#     DeleteSubscriptions = "allow"
#     EditSubscriptions = "allow"
#     PublishEvents = "allow"
#     ViewSubscriptions = "allow"
#   }
# }

# module "azuredevops_group" {
#   source = "../../templates/azuredevops/azuredevops_group"
#   origin_id = module.azuredevops_project.id
#   #name = var.azdo_project
# }
# module "azuredevops_team" {
#   source = "../../templates/azuredevops/azuredevops_team"
#   project_id = module.azuredevops_project.id
#   #name = var.azdo_project
# }
# module "azuredevops_user_entitlement" {
#   source = "../../templates/azuredevops/azuredevops_user_entitlement"
#   principal_name = var.azdo_project
# }
# module "azuredevops_group_membership" {
#   source = "../../templates/azuredevops/azuredevops_group_membership"
#   group = module.azuredevops_group.descriptor
#   members = [module.azuredevops_user_entitlement.id]
# }
# module "azuredevops_serviceendpoint_azurerm" {
#   source = "../../templates/azuredevops/azuredevops_serviceendpoint_azurerm"
#   project_id  = module.azuredevops_project.id
#   resource_group_name = var.resource_group_name
# }

# module "azuredevops_resource_authorization" {
#   source = "../../templates/azuredevops/azuredevops_resource_authorization"
#   project_id  = module.azuredevops_project.id
#   #resource_id = module.azuredevops_serviceendpoint_azurerm.key_vault.id
#   resource_id  = module.azuredevops_serviceendpoint_azurerm.id
#   authorized  = true
# }

# module "azuredevops_git_repository" {
#   source = "../../templates/azuredevops/azuredevops_git_repository"
#   project_id = module.azuredevops_project.id
#   resource_group_name = var.resource_group_name
# }
# module "azuredevops_build_definition" {
#   source = "../../templates/azuredevops/azuredevops_build_definition"
#   project_id = module.azuredevops_project.id
#   repo_id = module.azuredevops_git_repository.id
#   resource_group_name = var.resource_group_name
# }


# module "azuredevops_serviceendpoint_github" {
#   source = "../../templates/azuredevops/azuredevops_serviceendpoint_github"
#   resource_group_name = var.resource_group_name
#   location = var.location
# }


# module "azuredevops_variable_group" {
#   source = "../../templates/azuredevops/azuredevops_variable_group"
#   resource_group_name = var.resource_group_name
#   location = var.location
# }
# module "azuredevops_build_definition" {
#   source = "../../templates/azuredevops/azuredevops_build_definition"
#   resource_group_name = var.resource_group_name
#   location = var.location
# }

# module "azuredevops_serviceendpoint_azurecr" {
#   source = "../../templates/azuredevops_serviceendpoint_azurecr"
#   resource_group_name = var.resource_group_name
#   location = var.location
#     project_id                = azuredevops_project.example.id
#   service_endpoint_name     = "Example AzureCR"
#   resource_group            = "example-rg"
#   azurecr_spn_tenantid      = "00000000-0000-0000-0000-000000000000"
#   azurecr_name              = "ExampleAcr"
#   azurecr_subscription_id   = "00000000-0000-0000-0000-000000000000"
#   azurecr_subscription_name = "subscription name"
# }

# module "time-rotating" {
#   source = "../../templates/time-rotating"
#   end_date = var.password_end_date
#   rotation_days = var.password_rotation_days
#   rotation_years = var.password_rotation_years
# }
# module "azurerm_service_principal_certificate" {
#   source = "../../templates/azurerm/azurerm_service_principal_certificate"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
# }
# module "azurerm_service_principal" {
#   source = "../../templates/azurerm/azurerm_service_principal"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
# }
# module "azurerm_service_principal_password" {
#   source = "../../templates/azurerm/azurerm_service_principal_password"
#   azuread_service_principal_id = module.azurerm_service_principal.id
# }
# module "azurerm_role_assignment" {
#   source = "../../templates/azurerm/azurerm_role_assignment"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
# # # # }
# module "azurerm_log_analytics_workspace" {
#   source = "../../templates/azurerm/azurerm_log_analytics_workspace"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
# }
# module "azurerm_key_vault" {
#   source = "../../templates/azurerm/azurerm_key_vault"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
# }
# module "azurerm_kubernetes_cluster" {
#   source = "../../templates/azurerm/azurerm_kubernetes_cluster"
#   resource_group_name = module.azurerm_resource_group.name
#   location = module.azurerm_resource_group.location
#   default_node_pool = var.aks_default_node_pool
#   client_id = var.client_id #"${data.azurerm_key_vault_secret.ad_app.client_id}" # var.client_id
#   #client_secret = "${data.external.app_sp.result}" #var.client_secret
#   client_secret = "${data.azurerm_key_vault_secret.ad_app.value}" #var.client_secret
# }



# module "azurerm_container_registry" {
#   source = "../../templates/azurerm/azurerm_container_registry"
#   container_registry_webhooks = var.container_registry_webhooks
#   #acr_resource_group_name = var.acr_resource_group_name
#   location = module.azurerm_resource_group.location
#   sku = var.sku
#   admin_enabled = var.admin_enabled
#   #georeplications = var.georeplications
#   #network_rule_set
#   public_network_access_enabled = var.public_network_access_enabled
#   #quarantine_policy_enabled
#   #retention_policy
#   #trust_polizy
#   #zone_redundancy_enabled
#   #export_policy_enabled
#   #identity
#   #encryption
#   #anonymous_pull_enabled
#   #data_endpoint_enabled
# }

# module "azurerm_container_registry_webhook" {
#   source = "../../templates/azurerm/azurerm_container_registry_webhook"
#   for_each = var.webhooks
#   name = each.key
#   location = module.azurerm_resource_group.location
#   registry_name = var.registry_name
#   resource_group_name = module.azurerm_resource_group.name
# }

# module "azurerm_container_group" {
#   source = "../../templates/azurerm/azurerm_container_group"
#   for_each = var.container_groups
#   name = each.key
#   resource_group_name = module.azurerm_resource_group.name
# }

# # module "azurerm_network_security_group" {
# #   source = "../../templates/azurerm/azurerm_network_security_group"
# #   nsg_name = var.nsg_name
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_application_security_group" {
# #   source = "../../templates/azurerm/azurerm_application_security_group"
# #   asg_name = var.asg_name
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_virtual_network" {
# #   source = "../../templates/azurerm/azurerm_virtual_network"
# #   vnet_name = var.vnet_name
# #   subnets = {
# #     "s1" = { name = "TESTSUBNET", address = "10.0.1.0/24" },
# #     "s2" = { name = "TESTSUBNET1", address = "10.0.2.0/24" },
# #     "s3" = { name = "TESTSUBNET2", address = "10.0.3.0/24" }
# #   }
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_mssql_server" {
# #   source = "../../templates/azurerm/azurerm_mssql_server"
# #   dbserver_name = var.dbserver_name
# #   dbserver_version = var.dbserver_version
# #   dbserver_login = var.dbserver_login
# #   dbserver_pwd = var.dbserver_pwd
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_storage_account" {
# #   source = "../../templates/azurerm/azurerm_storage_account"
# #   sa_name = var.sa_name
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_mssql_database" {
# #   source = "../../templates/azurerm/azurerm_mssql_database"
# #   db_name = var.db_name
# #   sa_endpoint = module.azurerm_storage_account.endpoint
# #   sa_key = module.azurerm_storage_account.key
# #   dbserver_id = module.dbserver.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_mssql_database2" {
# #   source = "../../templates/azurerm/azurerm_mssql_database"
# #   db_name = "${var.db_name}2"
# #   sa_endpoint = module.azurerm_storage_account.endpoint
# #   sa_key = module.azurerm_storage_account.key
# #   dbserver_id = module.azurerm__mssql_server.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_app_service_plan" {
# #   source = "../../templates/azurerm/azurerm_app_service_plan"
# #   appserviceplan_name = var.appserviceplan_name
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_app_service" {
# #   source = "../../templates/azurerm/azurerm_app_service"
# #   app_name = "${var.resource_group_name}-app"
# #   app_serviceplanid = module.appserviceplan.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_app_service_api" {
# #   source = "../../templates/azurerm/azurerm_app_service"
# #   app_name = "${var.resource_group_name}-api"
# #   app_serviceplanid = module.azurerm_app_service_plan.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_app_service_app2" {
# #   source = "../../templates/azurerm/azurerm_app_service"
# #   app_name = "${var.resource_group_name}-app2"
# #   app_serviceplanid = module.azurerm_app_service_plan.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }
# # module "azurerm_app_service_api2" {
# #   source = "../../templates/azurerm/azurerm_app_service"
# #   app_name = "${var.resource_group_name}-api2"
# #   app_serviceplanid = module.azurerm_app_service_plan.id
# #   azurerm_resource_group_name = module.azurerm_resource_group.name
# #   location = module.azurerm_resource_group.location
# # }