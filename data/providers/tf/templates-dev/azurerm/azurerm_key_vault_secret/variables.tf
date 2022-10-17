variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "key_vault_id" {
  description = "The key_vault_id of the resource group"
  type        = string
  default     = null
}
variable "value" {
  description = "The value of the resource group"
  type        = string
  default     = null
}