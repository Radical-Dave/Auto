variable "name" {
  description = "The name of the azuread_group"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The name of the azuread_group"
  type = string
  default = null
}
variable "location" {
  description = "The location of the azuread_group"
  type = string
  default = "eastus"
}
variable "security_enabled" {
  description = "The security_enabled of the azuread_group"
  type = bool
  default = true
}
variable "tags" {
  description = "Tags for the azuread_group"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}