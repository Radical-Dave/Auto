variable "description" {
  description = "Additional defined_tags for the github_repository"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the github_repository"
  type        = string
}
variable "private" {
  description = "The privcate for the github_repository"
  type        = bool
  default     = false
}