variable "resource_group_name" {
  description = "The name of the azuread_application_password"
  type        = string
}
variable "location" {
  description = "The location of the azuread_application_password"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azuread_application_password"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}