variable "AUTH0_CLIENT_ID" {
  description = "The AUTH0_CLIENT_ID for auth0"
  type        = string
  default     = null
}
variable "AUTH0_CLIENT_SECRET" {
  description = "The AUTH0_CLIENT_SECRET for auth0"
  type        = string
  default     = null
}
variable "AUTH0_DOMAIN" {
  description = "The AUTH0_DOMAIN for auth0"
  type        = string
  default     = "project-dev.us.auth0.com"
}
variable "AUTH0_ORGANIZATION_COLOR_BACKGROUND" {
  description = "The AUTH0_ORGANIZATION_COLOR_BACKGROUND for auth0"
  type        = string
  default     = null
}
variable "AUTH0_ORGANIZATION_COLOR_PRIMARY" {
  description = "The AUTH0_ORGANIZATION_COLOR_PRIMARY for auth0"
  type        = string
  default     = null
}
variable "AUTH0_ORGANIZATION_LOGO" {
  description = "The AUTH0_ORGANIZATION_LOGO for auth0"
  type        = string
  default     = null
}
variable "AUTH0_ORGANIZATION_NAME" {
  description = "The AUTH0_ORGANIZATION_ID for auth0"
  type        = string
  default     = null
}
variable "ENVNAME" {
  description = "The env of the web app"
  type        = string
  default     = null
}
variable "PREFIX" {
  description = "The prefix of the web app"
  type        = string
  default     = null
}
variable "URLS" {
  description = "The URLS of the resource group"
  type        = string
  default     = null
}