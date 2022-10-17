variable "name" {
  description = "The name of the auth0_client"
  type        = string
  default     = null
}
variable "description" {
  description = "The description of the auth0_client"
  type        = string
  default     = null
}
variable "app_type" {
  description = "The app_type of the auth0_client [native,spa,regular_web,non_interactive,rms,box,cloudbees,concur,dropbox,mscrm,echosign,egnyte,newrelic,office365,salesforce,sentry,sharepoint,slack,springcm,zendesk,zoom]"
  type        = string
  default     = null
}
variable "logo_uri" {
  description = "The logo_uri of the auth0_client"
  type        = string
  default     = null
}
variable "cross_origin_auth" {
  description = "The cross_origin_auth of the auth0_client"
  type        = bool
  default     = false
}
variable "custom_login_page_on" {
  description = "The custom_login_page_on of the auth0_client"
  type        = bool
  default     = true
}
variable "id_token_expiration" {
  description = "The custom_login_page_on of the auth0_client"
  type        = number
  default     = 36000
}
variable "idle_token_lifetime" {
  description = "The idle_token_lifetime of the auth0_client"
  type        = number
  default     = 32000
}
variable "is_first_party" {
  description = "The is_first_party of the auth0_client"
  type        = bool
  default     = true
}
variable "is_token_endpoint_ip_header_trusted" {
  description = "The is_token_endpoint_ip_header_trusted of the auth0_client"
  type        = bool
  default     = true
}
variable "token_endpoint_auth_method" {
  description = "The token_endpoint_auth_method of the auth0_client [none,client_secret_basic,client_secret_post]"
  type        = string
  default     = null
}
variable "token_lifetime" {
  description = "The token_lifetime of the auth0_resource_server"
  type        = number
  default     = 86400
}
variable "oidc_conformant" {
  description = "The oidc_conformant of the auth0_client"
  type        = bool
  default     = false
}
variable "callbacks" {
  description = "The callbacks of the auth0_client - example: [\"https://example.com/callback\"]"
  type        = list(string)
  default     = null
}
variable "allowed_origins" {
  description = "The allowed_origins of the auth0_client - example: [\"https://example.com\"]"
  type        = list(string)
  default     = null
}
variable "grant_types" {
  description = "The grant_types of the auth0_client [authorization_code,http://auth0.com/oauth/grant-type/password-realm,implicit,password,refresh_token]"
  type        = list(string)
  default     = null
}
variable "allowed_logout_urls" {
  description = "The allowed_logout_urls of the auth0_client - example: [\"https://example.com\"]"
  type        = list(string)
  default     = null
}
variable "refresh_token_lifetime" {
  description = "The refresh_token_lifetime of the auth0_client"
  type        = number
  default     = 36000
}
variable "web_origins" {
  description = "The web_origins of the auth0_client - example: [\"https://example.com\"]"
  type        = list(string)
  default     = null
}