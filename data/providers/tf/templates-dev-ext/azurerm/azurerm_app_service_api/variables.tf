variable "always_on" {
  description = "The always_on of the web app"
  type        = string
  default     = "true"
}
variable "app_settings" {
  description = "The appsettings of the App"
  type        = map(string)
  default     = {}
  #{"WEBSITE_DNS_SERVER"="168.63.129.16" "WEBSITE_VNET_ROUTE_ALL"="1"}
}
variable "client_affinity_enabled" {
  description = "The client_affinity_enabled of the AppService Plan"
  type        = bool
  default     = false
}
variable "docker_image" {
  description = "The docker_image of the web app"
  type        = string
  default     = "true"
}
variable "docker_registry" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
variable "health_check_path" {
  description = "The health_check_path of the web app"
  type        = string
  default     = null
}
variable "https_only" {
  description = "The https_only of the AppService Plan"
  type        = bool
  default     = true
}
variable "kind" {
  description = "The kind of the web app"
  type        = string
  default     = null
}
variable "linux_fx_version" {
  description = "The linux_fx_version of the web app"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "scm_type" {
  description = "The scm_type of the web app"
  type        = string
  default     = null
}
variable "service_plan_id" {
  description = "The id of the AppService Plan"
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
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}