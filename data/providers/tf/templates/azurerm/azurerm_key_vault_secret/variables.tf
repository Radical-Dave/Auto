variable "name" {
  description = "The name of the virtual network"
  type = string
  default = ""
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default = ""
}
variable "vault_name" {
  description = "The azure_key_vault_id of the resource group"
  type = string
  default = ""
}