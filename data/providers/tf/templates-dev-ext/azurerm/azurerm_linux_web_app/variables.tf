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
variable "cors_origins" {
  description = "The cors_origins of the AppService"
  type        = list(string)
  default     = []
}
variable "docker_registry" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
variable "docker_image" {
  description = "The docker_image of the web app"
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
variable "ip_restriction" {
  description = "The ip_restriction of the App"
  #type=set(map(string))
  type = map(object({
    name                      = string #optional(string)
    action                    = string #optional(string)
    ip_address                = string #optional(string)
    service_tag               = string #optional(string)
    priority                  = string #optional(string)
    description               = string #optional(string)
    virtual_network_subnet_id = string #optional(string)
  }))
  default = {}
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
}
variable "scm_type" {
  description = "The scm_type of the web app"
  type        = string
  default     = "None"
}
variable "service_plan_id" {
  description = "The id of the AppService Plan"
  type        = string
  default     = null
}
variable "settings" {
  description = "The settings of the App"
  default     = {} #null#{site_config={always_on=true}}
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