variable "description" {
  description = "Additional defined_tags for the github_repository_file"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the github_repository_file"
  type        = string
}
variable "private" {
  description = "The private for the github_repository_file"
  type        = bool
  default     = false
}