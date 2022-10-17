variable "description" {
  description = "Additional defined_tags for the github_team_members"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the github_team_members"
  type        = string
}
variable "private" {
  description = "The privcate for the github_team_members"
  type        = bool
  default     = false
}