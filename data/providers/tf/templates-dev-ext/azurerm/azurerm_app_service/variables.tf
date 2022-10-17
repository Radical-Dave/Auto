variable "always_on" {
  description = "The always_on of the web app"
  type        = string
  default     = null
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
variable "client_cert_enabled" {
  description = "The client_cert_enabled of the AppService Plan"
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
variable "docker_image" {
  description = "The docker_image of the web app"
  type        = string
  default     = null
}
# variable docker_name {
#   description="The docker_name of the web app"
#   type=string
#   default=null
# }
variable "docker_registry" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
# variable docker_username {
#   description="The docker_username of the web app"
#   type=string
#   default=null
# }

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
variable "ip_restriction" {
  description = "The ip_restriction of the App"
  #type=set(map(string))
  type = list(object({
    #action=string
    #description=string
    ip_address = string
    #name=string
    #priority=string
    #service_tag=string
    virtual_network_subnet_id = string
  }))
  default = null
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
variable "log_sas_url" {
  description = "The log_sas_url of the resource group"
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
variable "settings" {
  description = "The settings of the App"
  default     = { site_config = { always_on = true } }
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}
variable "virtual_network_subnet_id" {
  description = "The virtual_network_subnet_id of the resource group"
  type        = string
  default     = null
}