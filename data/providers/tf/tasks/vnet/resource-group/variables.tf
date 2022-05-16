variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "crazyrg"
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}