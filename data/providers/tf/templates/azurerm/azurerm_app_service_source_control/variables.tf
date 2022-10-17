variable "app_id" {
  description = "The app_id of the App"
  type        = string
}
variable "branch" {
  description = "The branch of the App"
  type        = string
  default     = "master"
}
variable "repo_url" {
  description = "The repo_url of the App"
  type        = string
  default     = null
}
variable "rollback_enabled" {
  description = "The rollback_enabled of the App"
  type        = bool
  default     = true
}
variable "use_manual_integration" {
  description = "The use_manual_integration of the App"
  type        = bool
  default     = false
}
variable "use_mercurial" {
  description = "The use_mercurial of the App"
  type        = bool
  default     = false
}