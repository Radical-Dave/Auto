variable "name" {
  description = "The name of the log analytics workspace"
  type        = string
  default     = null
}
variable "log_analytics_workspace_sku" { default = "PerGB2018" }
variable "location" {
  description = "The location of the log analytics workspace - for available regions refer: https://azure.microsoft.com/global-infrastructure/services/?products=monitor"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "retention_in_days" {
  description = "The retention_in_days of the resource group"
  type        = number
  default     = 100
}
variable "sku" {
  description = "The sku of the log analytics workspace - for pricing refer: https://azure.microsoft.com/pricing/details/monitor"
  type        = string
  default     = "PerGB2018"
}
variable "tags" {
  description = "Tags for the log analytics workspace"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}