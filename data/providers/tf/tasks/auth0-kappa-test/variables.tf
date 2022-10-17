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