variable "name" {
  description = "The name of the application security group"
  type = string
  default = ""
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "location" {
  description = "The location of the resource group"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}