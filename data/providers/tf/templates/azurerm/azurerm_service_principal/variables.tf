variable "name" {
  description = "The name of the service principal"
  type = string
  default = "azdevops"
}
variable "location" {
  description = "The location of the service principal"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "sign_in_audience" {
  description = "The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`"
  type        = string
  default     = "AzureADMyOrg"
}
variable "alternative_names" {
  type        = list(string)
  description = "A set of alternative names, used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities."
  default     = []
}
variable "tenant_id" {
  description = "The tenant_id of the service principal"
  type = string
  default = ""
}

variable "description" {
  description = "A description of the service principal provided for internal end-users."
  default     = null
}

variable "tags" {
  description = "Tags for the service principal"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}