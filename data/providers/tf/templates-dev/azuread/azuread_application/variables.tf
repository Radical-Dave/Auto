variable "name" {
  description = "The name of the azuread_application"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the azuread_application"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azuread_application"
  type        = string
  default     = "eastus"
}
variable "sign_in_audience" {
  description = "The sign_in_audience of the azuread_application"
  type        = string
  default     = "AzureADMultipleOrgs"
}
variable "tags" {
  description = "Tags for the azuread_application"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}