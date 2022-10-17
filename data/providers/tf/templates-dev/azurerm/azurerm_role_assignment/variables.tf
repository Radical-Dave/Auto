variable "azuread_service_principal_id" {
  description = "The azuread_service_principal_id of the principal to assign the role definition to"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the role-assignment"
  type        = string
}
variable "roles" {
  description = "The list of role assignments to this service principal"
  type        = list(string)
  default     = []
}
variable "scope" {
  description = "The scope of the role-assignment"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the role-assignment"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}