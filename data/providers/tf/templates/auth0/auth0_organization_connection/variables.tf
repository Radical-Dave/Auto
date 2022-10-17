variable "assign_membership_on_login" {
  description = "The assign_membership_on_login of the auth0_organization_connection"
  type        = bool
  default     = true
}
variable "connection_id" {
  description = "The connection_id of the auth0_organization_connection"
  type        = string
}
variable "organization_id" {
  description = "The organization_id of the auth0_organization_connection"
  type        = string
}