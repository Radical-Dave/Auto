variable "name" {
  description = "The name of the auth0_resource_server"
  type        = string
  default     = null
}
variable "enforce_policies" {
  description = "The enforce_policies of the auth0_resource_server"
  type        = bool
  default     = false
}
variable "identifier" {
  description = "The identifier of the auth0_resource_server"
  type        = string
  default     = null
}
variable "signing_alg" {
  description = "The signing_alg of the auth0_resource_server [HS256,RS256]"
  type        = string
  default     = "RS256"
}
variable "signing_secret" {
  description = "The signing_secret of the auth0_resource_server [HS256,RS256]"
  type        = string
  default     = null
}
variable "allow_offline_access" {
  description = "The allow_offline_access of the auth0_resource_server"
  type        = bool
  default     = false
}
variable "token_dialect" {
  description = "The token_dialect of the auth0_resource_server [access_token,access_token_authz]"
  type        = string
  default     = null
}
variable "token_lifetime" {
  description = "The token_lifetime of the auth0_resource_server"
  type        = number
  default     = 86400
}
variable "token_lifetime_for_web" {
  description = "The token_lifetime_for_web of the auth0_resource_server"
  type        = number
  default     = 86400
}
variable "skip_consent_for_verifiable_first_party_clients" {
  description = "The skip_consent_for_verifiable_first_party_clients of the auth0_resource_server"
  type        = bool
  default     = true
}
variable "scopes" {
  description = "The scopes for the auth0_resource_server"
  type = list(object({
    description = string
    value       = string
  }))
  default = null
}