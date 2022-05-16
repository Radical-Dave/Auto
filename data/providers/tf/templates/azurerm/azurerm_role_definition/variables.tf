variable "name" {
  description = "The name of the virtual network"
  type = string
  default = ""
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "tenant_id" {
  description = "The tenant_id of the resource group"
  type = string
  default = ""
}
# variable "soft_delete_enabled" {
#   description = "The soft_delete_enabled of the resource group. The EnableSoftDelete feature must be used for TLS termination to function properly."
#   type        = bool
#   default = true
# }
# variable "soft_delete_retention_days" {
#   description = "The soft_delete_enabled of the resource group. The retention period must be kept at 90 days, the default value. Application Gateway doesn't support a different retention period yet."
#   type        = number
#   default = 90
# }
variable "purge_protection_enabled" {
  description = "The workspace_resource_id of the resource group"
  type        = bool
  default = false
}
variable "sku_name" {
  description = "The tenant_id of the resource group"
  type        = string
  default = "standard"
}
variable "network_acls" {
  description = "Network rules to apply to key vault."
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = {
    default_action = "Deny"
    bypass = "AzureServices"
    ip_rules = []
    virtual_network_subnet_ids = []
  }
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}