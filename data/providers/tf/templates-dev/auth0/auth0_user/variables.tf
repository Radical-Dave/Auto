variable "name" {
  description = "The name of the auth0_user"
  type        = string
  default     = null
}
variable "display_name" {
  description = "The display_name of the auth0_organization"
  type        = string
  default     = null
}
variable "connection_id" {
  description = "The connection_id of the auth0_organization"
  type        = string
  default     = null
}
variable "colors_primary" {
  description = "The colors_primary of the auth0_organization"
  type        = string
  default     = "#e3e2f0"
}
variable "colors_background" {
  description = "The colors_background of the auth0_organization"
  type        = string
  default     = "#e3e2ff"
}
variable "assign_membership_on_login" {
  description = "The assign_membership_on_login of the auth0_organization"
  type        = bool
  default     = false
}
variable "logo_url" {
  description = "The logo_url of the auth0_organization"
  type        = string
  default     = null
}