variable "permissions" {
  description = "The administrators of the azuredevops_servicehook_permissions being managed."
  type        = map(any)
}
variable "principal" {
  description = "The description of the azuredevops_servicehook_permissions being managed."
  type        = string
}
variable "project_id" {
  description = "The project_id of the group being managed."
  type        = string
  default     = null
}
variable "replace" {
  description = "The replace of the azuredevops_servicehook_permissions being managed."
  type        = bool
  default     = true
}