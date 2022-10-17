variable "azuread_service_principal_id" {
  description = "The azuread_service_principal_id"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "certificate_type" {
  description = "The certificate_type of the resource group"
  type        = string
  default     = null
}
variable "certificate_encoding" {
  description = "The certificate_encoding of the resource group"
  type        = string
  default     = null
}
variable "key_id" {
  description = "The key_id of the resource group"
  type        = string
  default     = null
}
variable "certificate_path" {
  description = "The certificate_path of the resource group"
  type        = string
  default     = null
}
variable "enable_service_principal_certificate" {
  type        = bool
  description = "Manages a Certificate associated with a Service Principal within Azure Active Directory"
  default     = false
}
# variable soft_delete_enabled {
#   description="The soft_delete_enabled of the resource group. The EnableSoftDelete feature must be used for TLS termination to function properly."
#   type=bool
#   default=true
# }
# variable soft_delete_retention_days {
#   description="The soft_delete_enabled of the resource group. The retention period must be kept at 90 days, the default value. Application Gateway doesn't support a different retention period yet."
#   type=number
#   default=90
# }
variable "purge_protection_enabled" {
  description = "The workspace_resource_id of the resource group"
  type        = bool
  default     = false
}
variable "sku_name" {
  description = "The tenant_id of the resource group"
  type        = string
  default     = "standard"
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
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}
variable "password_end_date" {
  description = "The relative duration or RFC3339 rotation timestamp after which the password expire"
  default     = null
}

variable "password_rotation_years" {
  description = "Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password_end_date and either one is specified and not the both"
  default     = null
}

variable "password_rotation_days" {
  description = "Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation.Conflicts with `password_end_date`, `password_rotation_in_years` and either one must be specified, not all"
  default     = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}