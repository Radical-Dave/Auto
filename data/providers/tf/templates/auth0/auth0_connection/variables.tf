variable "brute_force_protection" {
  description = "The brute_force_protection of the auth0_connection"
  type        = bool
  default     = false
}
variable "display_name" {
  description = "The display_name of the auth0_connection"
  type        = string
  default     = null
}
variable "enabled_clients" {
  description = "The enabled_clients of the auth0_connection"
  type        = set(string)
  default     = null
}
variable "is_domain_connection" {
  description = "The is_domain_connection of the auth0_connection"
  type        = bool
  default     = false
}
variable "name" {
  description = "The name of the auth0_connection"
  type        = string
}
variable "strategy" {
  description = "The strategy of the auth0_connection"
  type        = string
  default     = "auth0"
}