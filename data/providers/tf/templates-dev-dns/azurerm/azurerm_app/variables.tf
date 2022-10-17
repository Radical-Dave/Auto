variable "app_sp" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "azdevops"
}
variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
# variable prefix {
#   description="The prefix of the web app"
#   type=string
#   default=null
# }
# variable envname {
#   description="The env of the web app"
#   type=string
#   default=null
# }
variable "defaultdomain" {
  description = "The default domain of the web apps"
  type        = string
  default     = null
}
variable "domain" {
  description = "The domain of the web apps"
  type        = string
  default     = null
}
variable "host" {
  description = "The HOST of the AppService Plan"
  type        = string
  default     = null
}
variable "hostname" {
  description = "The HOSTNAME of the AppService Plan"
  type        = string
  default     = null
}

variable "app_settings" {
  description = "The appsettings of the App"
  type        = map(string)
  default     = {}
  #{"WEBSITE_DNS_SERVER"="168.63.129.16" "WEBSITE_VNET_ROUTE_ALL"="1"}
}
variable "service_plan_id" {
  description = "The id of the AppService Plan"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "https_only" {
  description = "The https_only of the AppService Plan"
  type        = bool
  default     = true
}
variable "client_affinity_enabled" {
  description = "The client_affinity_enabled of the AppService Plan"
  type        = bool
  default     = false
}
variable "connection_strings" {
  description = "The connection_strings for the app"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = null
}
variable "cors_origins" {
  description = "The cors_origins of the AppService"
  type        = list(string)
  default     = []
}
variable "kind" {
  description = "The kind of the web app"
  type        = string
  default     = null
}
variable "dns_resource_group_name" {
  description = "The dns_resource_group_name of the web apps"
  type        = string
  default     = "DNS_Zone_RG"
}
variable "zone_name" {
  description = "The zone_name of the web apps"
  type        = string
  default     = null
}
variable "docker_image" {
  description = "The docker_image of the web app"
  type        = string
  default     = null
}
variable "docker_name" {
  description = "The docker_name of the web app"
  type        = string
  default     = null
}
variable "docker_password" {
  description = "The docker_password of the web app"
  type        = string
  default     = null
}
variable "docker_registry" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
variable "docker_username" {
  description = "The docker_username of the web app"
  type        = string
  default     = null
}
variable "scm_type" {
  description = "The scm_type of the web app"
  type        = string
  default     = null
}
variable "always_on" {
  description = "The always_on of the web app"
  type        = string
  default     = null
}
variable "linux_fx_version" {
  description = "The linux_fx_version of the web app"
  type        = string
  default     = null
}
variable "health_check_path" {
  description = "The health_check_path of the web app"
  type        = string
  default     = null
}
variable "projectpay_password" {
  description = "The projectpay_password of the web app"
  type        = string
  default     = null
}
variable "projectpay_username" {
  description = "The projectpay_username of the web app"
  type        = string
  default     = null
}
variable "projectpay_uri" {
  description = "The projectpay_uri of the web app"
  type        = string
  default     = "ftp.projectpay.com"
}
variable "phicure_password" {
  description = "The phicure_password of the web app"
  type        = string
  default     = null
}
variable "phicure_username" {
  description = "The phicure_username of the web app"
  type        = string
  default     = null
}
variable "phicure_uri" {
  description = "The phicure_uri of the web app"
  type        = string
  default     = "sftp.phicure.com"
}
variable "project_api_key" {
  description = "The project_api_key of the resource group"
  type        = string
  default     = null
}
variable "project_api_audience" {
  description = "The project_api_audience of the resource group"
  type        = string
  default     = null
}
variable "project_api_authority" {
  description = "The project_api_authority of the resource group"
  type        = string
  default     = "https://project-dev.us.auth0.com"
}
variable "project_api_auth0_org" {
  description = "The project_api_auth0_org of the resource group"
  type        = string
  default     = null
}
variable "project_api_client_id" {
  description = "The project_api_client_id of the resource group"
  type        = string
  default     = null
}
variable "project_api_client_secret" {
  description = "The project_api_client_secret of the resource group"
  type        = string
  default     = null
}
variable "project_api_origins" {
  description = "The project_api_origins of the AppService"
  type        = string
  default     = null
}
variable "site_config" {
  description = "The site_config of the App"
  type = object(
    {
      scm_type          = string
      always_on         = string
      linux_fx_version  = string
      health_check_path = string
    }
  )
  default = null
  # {
  #   site_config={
  #     scm_type="GIT"
  #     always_on="true"
  #     linux_fx_version="DOCKER|${var.docker_registry}/${var.docker_image}:latest"
  #     health_check_path="/health"
  #   }
  #  }
  #{"WEBSITE_DNS_SERVER"="168.63.129.16" "WEBSITE_VNET_ROUTE_ALL"="1"}
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}
variable "log_sas_url" {
  description = "The log_sas_url of the resource group"
  type        = string
  default     = null
}
variable "virtual_network_subnet_id" {
  description = "The virtual_network_subnet_id of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}