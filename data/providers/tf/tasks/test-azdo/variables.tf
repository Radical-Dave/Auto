variable "subscription_id" {
  description = "The subscription_id of the resource group"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "azdo_org_service_url" {
  description = "The azdo_org_service_url of the resource group"
  type        = string
  default     = null
}
variable "azdo_personal_access_token" {
  description = "The azdo_personal_access_token of the azuredevops_project"
  type        = string
}
variable "azdo_project" {
  description = "The azdo_project of the resource group"
  type        = string
  default     = null
}
variable "description" {
  description = "The description of the resource group"
  type        = string
  default     = null
}