locals {
  #name=coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-api" : "api")
  #name=length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}-api" : "project-${var.resource_group_name}-api": "project-api"
  name              = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}-api" : "project-${var.resource_group_name}-api" : "project-api"
  kind              = length(var.kind != null ? var.kind : "") > 0 ? var.kind : ""
  location          = coalesce(var.location, "eastus")
  scm_type          = length(var.scm_type != null ? var.scm_type : "") > 0 ? var.scm_type : "None"
  always_on         = length(var.always_on != null ? var.always_on : "") > 0 ? var.always_on : "true"
  fx_version        = length(var.docker_registry != null ? "${var.docker_registry}${var.docker_image}" : "") > 0 ? "DOCKER|${var.docker_registry}/${var.docker_image}:latest" : null
  health_check_path = length(var.health_check_path != null ? var.health_check_path : "") > 0 ? var.health_check_path : "/health"
  site_config = length(var.site_config != null ? var.site_config : {}) > 0 ? var.site_config : length(var.docker_registry != null ? var.docker_registry : "") == 0 ? {} : {
    scm_type          = local.scm_type
    always_on         = local.always_on
    linux_fx_version  = local.fx_version
    health_check_path = local.health_check_path
  }
}
data "azurerm_key_vault" "kv" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
data "azurerm_key_vault_secret" "db_connectionstring" {
  name         = "${var.resource_group_name}-db-connectionstring"
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_app_service" "this" {
  name                    = local.name
  location                = local.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.service_plan_id
  app_settings            = var.app_settings
  https_only              = var.https_only
  client_affinity_enabled = var.client_affinity_enabled
  #site_config=var.site_config
  # dynamic "site_config" {
  #   for_each=local.site_config != null ? [true] : []
  #   content {
  #     #scm_type=local.site_config.scm_type
  #     # always_on=local.site_config.always_on
  #     # linux_fx_version=local.site_config.linux_fx_version
  #     # health_check_path=local.site_config.health_check_path
  #     # acr_use_managed_identity_credentials=false
  #     # http2_enabled=true
  #     #scm_type=local.site_config.scm_type
  #     #always_on=local.site_config.always_on
  #     #linux_fx_version=local.site_config.linux_fx_version
  #     #health_check_path=local.site_config.health_check_path
  #     #acr_use_managed_identity_credentials=false
  #     #http2_enabled=true
  #     acr_use_managed_identity_credentials=true
  #     always_on=local.always_on
  #     ftps_state="Disabled"
  #     health_check_path=local.health_check_path
  #     http2_enabled=true
  #     number_of_workers=3
  #     scm_type="None" 
  #   }
  # }
  site_config {
    #scm_type=local.site_config.scm_type
    #always_on=local.site_config.always_on
    #linux_fx_version=local.site_config.linux_fx_version
    #health_check_path=local.site_config.health_check_path
    acr_use_managed_identity_credentials = false
    always_on                            = local.always_on
    ftps_state                           = "Disabled"
    health_check_path                    = local.health_check_path
    http2_enabled                        = true
    number_of_workers                    = 3
    scm_type                             = local.scm_type
    #windows_fx_version=local.windows_fx_version
    linux_fx_version = local.fx_version
    # application_stack {
    #   docker_container_name="${var.docker_registry}/${var.docker_image}"
    #   docker_image_tag="latest"
  }
  # connection_string {
  #   name="db"
  #   type="SQLAzure"
  #   #value="@Microsoft.KeyVault(SecretUri=https://myvault.vault.azure.net/secrets/mysecret/)"
  #   value="@Microsoft.KeyVault(SecretUri=${data.azurerm_key_vault_secret.db_connectionstring.uri}})"
  #   #value="Server=some-server.mydomain.com;Integrated Security=SSPI"
  #   #Server=tcp:dev-vantage-db-server.database.windows.net,1433;Initial Catalog=dev-vantage-db;Persist Security Info=False;User ID=albatross;Password=F4j$3rLt0PAy;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
  # }
  tags = var.tags
}