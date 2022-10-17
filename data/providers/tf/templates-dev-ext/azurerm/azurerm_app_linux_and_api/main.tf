locals {
  #app_settings=try(length(var.app_settings != null ? var.app_settings : "") > 0 ? var.app_settings : tomap(local.app_settings_default), {})  
  #app_settings=merge(local.app_settings_appinsights,local.app_settings_docker,local.app_settings_web_storage)
  app_settings          = merge(local.app_settings_appinsights_default, local.app_settings_docker, local.app_settings_web_storage)
  app_settings_api      = merge(local.app_settings, local.app_settings_website)
  app_settings_api_core = merge(local.app_settings_api, local.app_settings_project)
  app_settings_appinsights_default = {
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "disabled"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "disabled"
    "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT"       = ""
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "disabled"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "default"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }
  app_settings_docker = {
    "DOCKER_ENABLE_CI" = "true"
    #"DOCKER_CUSTOM_IMAGE_NAME"="DOCKER|${var.app}"
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_password
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_username
    #"WEBSITE_PULL_IMAGE_OVER_VNET":"true"
  }
  app_settings_project = {
    "AUTH0_DB_CONNECTION"               = lookup(var.ext, "AUTH0_DB_CONNECTION", "Username-Password-Authentication")
    "FTP_projectPAY_PRGRIN_FTPPASSWORD" = lookup(var.ext, "FTP_projectPAY_PRGRIN_FTPPASSWORD", null)
    "FTP_projectPAY_PRGRIN_FTPUSERNAME" = lookup(var.ext, "FTP_projectPAY_PRGRIN_FTPUSERNAME", null)
    "FTP_projectPAY_URI"                = lookup(var.ext, "FTP_projectPAY_URI", null)
    "FTP_PHICURE_PRGRIN_FTPPASSWORD"    = lookup(var.ext, "FTP_PHICURE_PRGRIN_FTPPASSWORD", null)
    "FTP_PHICURE_PRGRIN_FTPUSERNAME"    = lookup(var.ext, "FTP_PHICURE_PRGRIN_FTPUSERNAME", null)
    "FTP_PHICURE_PORT"                  = lookup(var.ext, "FTP_PHICURE_PORT", "22")
    "FTP_PHICURE_URI"                   = lookup(var.ext, "FTP_PHICURE_URI", null)
    "MANAGEMENT_API_AUDIENCE"           = lookup(var.ext, "project_API_AUDIENCE", "https://project-dev.us.auth0.com/api/v2/")
    "project_API_AUDIENCE"            = lookup(var.ext, "project_API_AUDIENCE", "https://api.${var.hostname}")
    "project_API_AUTH0_ORG"           = lookup(var.ext, "project_API_AUTH0_ORG", null)
    "project_API_AUTHORITY"           = lookup(var.ext, "project_API_AUTHORITY", null)
    "project_API_CLIENT_ID"           = lookup(var.ext, "project_API_CLIENT_ID", null)
    "project_API_CLIENT_SECRET"       = lookup(var.ext, "project_API_CLIENT_SECRET", null)
    "project_API_KEY"                 = lookup(var.ext, "project_API_KEY", null)
    "project_API_ORIGINS"             = lookup(var.ext, "project_API_ORIGINS", null)
    "project_NO_INIT_PROCS"           = lookup(var.ext, "project_API_ORIGINS", "false")
  }
  app_settings_website = merge({
    "ASPNETCORE_ENVIRONMENT" = "Development"
    "WEBSITES_PORT"          = "80"
    #"WEBSITE_HTTPLOGGING_RETENTION_DAYS"="1"
  }, local.app_settings_web_storage)
  app_settings_web_storage = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
  name = length(var.name != null ? var.name : "") > 0 ? var.name : var.resource_group_name
  settings = merge(var.settings, {
    client_affinity_enabled = false #var.client_affinity_enabled
    connection_strings = [{
      name = "VantageDatabase"
      type = "SQLAzure"
      #value="${module.azurerm_mssql_server.connection_string};Initial Catalog=${local.name}-db;"
      value = "${var.db};Initial Catalog=${local.name}-db;"
      #value="Server=tcp:${var.dbserver_name}.database.windows.net,1433;Initial Catalog=${var.db_name};Persist Security Info=False;User ID=${var.dbserver_login};Password=${var.dbserver_pwd};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
      #value="@Microsoft.KeyVault(SecretUri=${module.azurerm_mssql_server.connection_string}})"    
    }]
    enabled    = true
    https_only = true
    logs = {
      application_logs = {
        azure_blob_storage = {
          #Error,Warning,Information,Verbose,Off
          level             = "Warning"
          retention_in_days = 7
          sas_url           = var.log_sas_url
        }
        file_system_level = "Warning"
      }
      http_logs = {
        file_system = {
          retention_in_days = 7
          retention_in_mb   = 35
        }
      }
    }
    #site_config=local.site_config
    site_config = {
      acr_use_managed_identity_credentials = false
      always_on                            = true
      ftps_state                           = "Disabled"
      http2_enabled                        = true
      number_of_workers                    = 3
      vnet_route_all_enabled               = false
    }
    vault_name           = var.vault_name
    vault_resource_group = var.vault_resource_group
    #virtual_network_subnet_id_app=module.azurerm_subnet_web.id
    #virtual_network_subnet_id_api=module.azurerm_subnet_api.id
    zone_name = var.zone_name
  })
  # settings_api={
  #   site_config={
  #     # application_stack={
  #     #   docker_container_name="${var.docker_registry}/${var.api}"
  #     #   docker_image_tag="latest"
  #     # }
  #     #cors=split(",",var.project_api_origins)
  #     health_check_path="/swagger/v1/swagger.json"
  #     #linux_fx_version="DOCKER|${var.docker_registry}/${var.api}"    
  #   }    
  # }
  # settings_app={
  #   site_config={
  #     # application_stack={
  #     #   docker_container_name="${var.docker_registry}/${var.app}"
  #     #   docker_image_tag="latest"
  #     # }
  #     health_check_path="/health"
  #     #linux_fx_version="DOCKER|${var.docker_registry}/${var.app}"
  #   }
  # }
}
module "azurerm_app" {
  source       = "../azurerm_app_linux"
  app_settings = merge(local.app_settings, { "DOCKER_CUSTOM_IMAGE_NAME" = "DOCKER|${var.docker_registry}/${var.app}" })
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  #connection_strings=var.connection_strings
  dns_domain              = var.dns_domain
  dns_resource_group_name = var.dns_resource_group_name
  #ext=var.ext
  host       = var.host
  hostname   = var.hostname
  https_only = var.https_only
  #linux_fx_version="DOCKER|${var.docker_registry}/${var.app}:latest"
  location            = var.location
  log_sas_url         = var.log_sas_url
  name                = "${local.name}-app"
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  #settings=local.settings
  settings = merge(local.settings, { #local.settings_app,{
    site_config = {
      # application_stack={
      #   docker_container_name="${var.docker_registry}/${var.app}"
      #   docker_image_tag="latest"
      # }
      health_check_path = "//swagger/v1/swagger.json"
      #linux_fx_version="DOCKER|${var.docker_registry}/${var.app}"
      number_of_workers = 3
    }
  })
  virtual_network_subnet_id = var.virtual_network_subnet_id_app
  zone_name                 = var.zone_name
}
module "azurerm_api" {
  source = "../azurerm_app"
  #app_settings=merge((length(regexall(".*-core-*", var.api)) == 0 ? local.app_settings_api : local.app_settings_api_core),{"DOCKER_CUSTOM_IMAGE_NAME"="DOCKER|${var.docker_registry}/${var.api}"})
  app_settings = merge(local.app_settings_api, var.ext, { "DOCKER_CUSTOM_IMAGE_NAME" = "DOCKER|${var.docker_registry}/${var.api}" })
  #app_sp=var.app_sp
  client_affinity_enabled = var.client_affinity_enabled
  dns_domain              = var.dns_domain
  dns_resource_group_name = var.dns_resource_group_name
  #ext=var.ext
  host                = "api.${var.host}"
  hostname            = "api.${var.hostname}"
  https_only          = var.https_only
  location            = var.location
  log_sas_url         = var.log_sas_url
  name                = "${local.name}-api"
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  #settings=merge(local.settings,local.settings_api)
  settings = merge(local.settings, { #local.settings_api,{
    site_config = {
      # application_stack={
      #   docker_container_name="${var.docker_registry}/${var.app}"
      #   docker_image_tag="latest"
      # }
      #health_check_path="/health"
      #linux_fx_version="DOCKER|${var.docker_registry}/${var.app}"
      number_of_workers = 3
    }
  })
  virtual_network_subnet_id = var.virtual_network_subnet_id_api
  zone_name                 = var.zone_name
}