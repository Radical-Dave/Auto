variable "application_object_id" {
  description = "The application_object_id of the azuread_application"
  type = string
}
variable "audiences" {
  description = "The audiences of the azuread_application"
  type = list(string)
}
variable "description" {
  description = "The description of the azuread_application"
  type = string
  default = null
}
variable "display_name" {
  description = "The display_name of the azuread_application"
  type = string
  default = null
}
variable "issuer" {
  description = "The issuer of the azuread_application"
  type = string
}
variable "resource_group_name" {
  description = "The name of the azuread_application"
  type = string
  default = null
}
variable "subject" {
  description = "The subject of the azuread_application"
  type = string
}