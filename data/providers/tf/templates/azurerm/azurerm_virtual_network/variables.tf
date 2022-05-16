variable "name" {
  description = "The name of the virtual network"
  type = string
  default = ""
}
variable "location" {
  description = "The location of the virtual network"
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "addresses" {
  description = "The addresses of the virtual network"
  type = list
  default = ["10.0.0.0/16"]
}
variable "subnets" {
  description = "Subnets for the virtual network"
  type = map(object({
    name = string
    address = string
  }))
  default = {}
}
variable "tags" {
  description = "Tags for the virtual network"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}