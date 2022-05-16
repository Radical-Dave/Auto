variable "name" {
  description = "The name of the storage account"
  type = string
  default = ""
}
variable "sa_tier" {
  description = "The tier of the storage account"
  type = string
  default = "Standard"
}
variable "sa_reptype" {
  description = "The replication_type of the storage account"
  type = string
  default = "LRS"
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "location" {
  description = "The location of the resource group"
  type = string
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}