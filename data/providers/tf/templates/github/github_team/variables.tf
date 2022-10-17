variable "create_default_maintainer" {
  description = "The create_default_maintainer for the github_team"
  type        = bool
  default     = false
}
variable "description" {
  description = "The description for the github_team"
  type        = string
  default     = null
}
variable "ldap_dn" {
  description = "The ldap_dn for the github_team"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the github_team"
  type        = string
}
variable "parent_team_id" {
  description = "The parent_team_id for the github_team"
  type        = string
  default     = null
}
variable "privacy" {
  description = "The privacy for the github_team"
  type        = string
  default     = "secret"
}