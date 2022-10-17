variable "name" {
  description = "The name of the storage account"
  type        = string
  default     = null
}
variable "container_access_type" {
  description = "The container_access_type of the storage account [blob,container,private]"
  type        = string
  default     = "private"
}
variable "storage_account_name" {
  description = "The storage_account_name of the storage account"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}