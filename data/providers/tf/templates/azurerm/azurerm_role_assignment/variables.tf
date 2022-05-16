variable "azuread_service_principal_id" {
  description = "The azuread_service_principal_id of the principal to assign the role definition to"
  type = string
  default = ""
}
variable "name" {
  description = "The name of the role-assignment"
  type = string
  default = ""
}
variable "location" {
  description = "The location of the role-assignment"
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "roles" {
  description = "The list of role assignments to this service principal"
  type = list(string)
  default = []
}
variable "scope" {
  description = "The scope of the role-assignment"
  type = string
  default = ""
}
variable "tags" {
  description = "Tags for the role-assignment"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}