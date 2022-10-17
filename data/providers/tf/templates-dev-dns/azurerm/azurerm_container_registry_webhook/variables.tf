#   container_registry_config {
#   description="Manages an Azure Container Registry"
#   type=object({
#     name                         =string
#     admin_enabled                =optional(bool)
#     sku                          =optional(string)
#     public_network_access_enabled=optional(bool)
#     quarantine_policy_enabled    =optional(bool)
#     zone_redundancy_enabled      =optional(bool)
#   })
# }
variable "name" {
  description = "The name of the container registry"
  type        = string
  default     = null
}
variable "registry_name" {
  description = "The registry_name of the container registry"
  type        = string
}
variable "service_uri" {
  description = "The service_uri of the container registry"
  type        = string
  default     = null
}
variable "actions" {
  description = "The actions of the container registry"
  type        = list(string)
  default     = null
}
variable "status" {
  description = "The status of the container registry"
  #type=optional(string)
  type    = string
  default = null
}
variable "scope" {
  description = "The scope of the container registry"
  type        = string
  default     = null
}
variable "custom_headers" {
  description = "The custom_headers of the container registry"
  type        = map(string)
  default     = null
}
variable "acr_sku" {
  description = "The sku of the container registry"
  type        = string
  default     = "Standard"
}
variable "acr_admin_enabled" {
  description = "The admin enabled of the container registry"
  type        = bool
  default     = true
}
variable "acr_public_network_access_enabled" {
  description = "The public network access enabled of the container registry"
  type        = bool
  default     = true
}
variable "acr_quarantine_policy_enabled" {
  description = "The quarantine policy enabled of the container registry"
  type        = bool
  default     = false
}
variable "acr_zone_redundancy_enabled" {
  description = "The zone redundancy enabled of the container registry"
  type        = bool
  default     = false
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}
variable "georeplications" {
  description = "A list of Azure locations where the container registry should be geo-replicated"
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool)
  }))
  default = []
}
variable "network_rule_set" { # change this to match actual objects
  description = "Manage network rules for Azure Container Registries"
  type = object({
    default_action = optional(string)
    ip_rule = optional(list(object({
      ip_range = string
    })))
    virtual_network = optional(list(object({ subnet_id = string })))
  })
  default = null
}
variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}
variable "enable_content_trust" {
  description = "Boolean value to enable or disable Content trust in Azure Container Registry"
  default     = false
}
variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`"
  default     = null
}
variable "encryption" {
  description = "Encrypt registry using a customer-managed key"
  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}
variable "scope_map" {
  description = "Manages an Azure Container Registry scope map. Scope Maps are a preview feature only available in Premium SKU Container registries."
  type = map(object({
    actions = list(string)
  }))
  default = null
}
variable "container_registry_webhooks" {
  description = "Manages an Azure Container Registry Webhook"
  type = map(object({
    service_uri    = string
    actions        = list(string)
    status         = optional(string)
    scope          = string
    custom_headers = map(string)
  }))
  default = null
}
variable "enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure Container Registry"
  default     = false
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  default     = null
}
variable "existing_private_dns_zone" {
  description = "Name of the existing private DNS zone"
  default     = null
}
variable "private_subnet_address_prefix" {
  description = "The name of the subnet for private endpoints"
  default     = null
}
variable "log_analytics_workspace_name" {
  description = "The name of log analytics workspace name"
  default     = null
}
variable "storage_account_name" {
  description = "The name of the hub storage account to store logs"
  default     = null
}
variable "acr_diag_logs" {
  description = "Application Gateway Monitoring Category details for Azure Diagnostic setting"
  default     = ["ContainerRegistryRepositoryEvents", "ContainerRegistryLoginEvents"]
}
variable "tags" {
  description = "A map of tags to add to resource"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}