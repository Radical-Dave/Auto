variable "account_license_type" {
  description = "The account_license_type of the azuredevops_user_entitlement"
  type        = string
  default     = "stakeholder"
}
variable "principal_name" {
  description = "The principal_name of the azuredevops_user_entitlement"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_group"
  type        = string
  default     = null
}