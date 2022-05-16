variable "key_vault_id" {
  description = "The key_vault_id of the virtual network"
  type = string
}
variable "tenant_id" {
  description = "The tenant_id of the resource group"
  type = string
}
variable "object_id" {
  description = "The object_id of the virtual network"
  type = string
}
variable "key_permissions" {
  description = "The key_permissions of the resource group."
  type = list(string)
  default = ["get"]
}
variable "secret_permissions" {
  description = "The secret_permissions of the resource group."
  type = list(string)
  default = ["get"]
}
variable "tags" {
  description = "Tags for the virtual network"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}