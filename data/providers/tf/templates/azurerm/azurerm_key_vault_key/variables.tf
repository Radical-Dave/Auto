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
variable "azure_key_vault_id" {
  description = "The azure_key_vault_id of the resource group"
  type = string
  default = ""
}
variable "key_type" {
  description = "The key_type of the resource group"
  type = string
  default = "RSA"
}
variable "key_size" {
  description = "The key_size of the resource group"
  type = number
  default = 2048
}
variable "key_opts" {
  description = "Network rules to apply to key vault."
  type = list(string)
  default = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}