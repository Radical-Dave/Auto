variable "name" {
  description = "The name of the AppService Plan"
  type = string
  default = null
}
variable "app_settings" {
  description = "The appsettings of the App"
  type = map(string)
  default = {}
  #{"WEBSITE_DNS_SERVER" = "168.63.129.16" "WEBSITE_VNET_ROUTE_ALL" = "1"}
}
variable "service_plan_id" {
  description = "The id of the AppService Plan"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "https_only" {
  description = "The https_only of the AppService Plan"
  type = bool
  default = true
}
variable "client_affinity_enabled" {
  description = "The client_affinity_enabled of the AppService Plan"
  type = bool
  default = true
}
variable "kind" {
  description = "The kind of the web app"
  type = string
  default = null
}
variable "docker_app" {
  description = "The docker_app of the web app"
  type = string
  default = "true"
}
variable "docker_repo" {
  description = "The docker_repo of the web app"
  type = string
  default = ""
}
variable "linux_fx_version" {
  description = "The linux_fx_version of the web app"
  type = string
  default = ""
}
variable "site_config" {
  description = "The site_config of the App"
  type = object(
    {
      scm_type = string
      always_on = string
      linux_fx_version = string
      health_check_path = string
    }
  )
  default = null
  # {
  #   site_config = {
  #     scm_type = "GIT"
  #     always_on = "true"
  #     linux_fx_version = "DOCKER|${var.docker_repo}/${var.docker_app}:latest"
  #     health_check_path = "/health"
  #   }
  #  }
  #{"WEBSITE_DNS_SERVER" = "168.63.129.16" "WEBSITE_VNET_ROUTE_ALL" = "1"}
}
variable "location" {
  description = "The location of the resource group"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}