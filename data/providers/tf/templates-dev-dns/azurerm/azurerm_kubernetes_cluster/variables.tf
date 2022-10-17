variable "name" {
  description = "The name of the aks"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the aks"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "default_node_pool" {
  description = "The plan of the log analytics solution"
  type = object({
    name                = string
    vm_size             = string # default: Standard_DS2_v2
    enable_auto_scaling = bool   # default: false
  })
}
variable "key_vault_secrets_provider" {
  description = "The key_vault_secrets_provider of the aks"
  type = map(object({
    address            = string #env:VAULT_ADDR
    add_address_to_env = bool   # default:false
    token              = string # env:VAULT_TOKEN, ~/.vault-token
    token_name         = string # env:VAULT_TOKEN_NAME, default: terraform
  }))
  default = {}
}
variable "client_id" {
  description = "The client_id of the aks"
  type        = string
  default     = null
}
variable "client_secret" {
  description = "The client_secret of the aks"
  type        = string
  default     = null
}
variable "dns_prefix" {
  description = "The dns_prefix of the aks"
  type        = string
  default     = null
}
variable "dns_prefix_private_cluster" {
  description = "The dns_prefix_private_cluster of the aks"
  type        = string
  default     = null
}
variable "ssh_public_key" {
  description = "The ssh_public_key of the aks"
  type        = string
  default     = "~/.ssh/aks-default.pub"
}
variable "node_count" {
  description = "The node_count of the aks"
  type        = number
  default     = 1
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}