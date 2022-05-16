variable "name" {
  description = "The name of the firewall"
  type = string
  default = ""
}
variable "location" {
  description = "The location of the firewall"
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "addresses" {
  description = "The addresses of the firewall"
  type = list
  default = ["10.0.0.0/16"]
}
variable "subnets" {
  description = "Subnets for the firewall"
  type = map(object({
    name = string
    address = string
  }))
}
variable "tags" {
  description = "Tags for the firewall"
  type = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}