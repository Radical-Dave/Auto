variable resource_group_name {
  description = "The name of the resource group"
  type        = string
  default     = "aks-test"
}
variable location {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable storageaccount_name {
  description = "The name of the resource group"
  type        = string
  default     = "akssa"
}
variable container_name {
  description = "The name of the resource group"
  type        = string
  default     = "aks-container"
}