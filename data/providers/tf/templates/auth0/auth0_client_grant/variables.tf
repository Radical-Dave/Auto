variable "audience" {
  description = "The name of the auth0_client_grant"
  type        = string
  default     = null
}
variable "client_id" {
  description = "The description of the auth0_client_grant"
  type        = string
  default     = null
}
variable "scope" {
  description = "The scope of the auth0_client_grant"
  type        = list(string)
  default     = []
}