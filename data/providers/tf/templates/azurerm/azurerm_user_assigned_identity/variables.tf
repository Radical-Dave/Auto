variable "name" {
  description = "The name of the virtual network"
  type        = string
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}