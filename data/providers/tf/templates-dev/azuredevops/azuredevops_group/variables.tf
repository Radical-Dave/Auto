variable "description" {
  description = "The description of the group being managed."
  type        = string
  default     = null
}
variable "display_name" {
  description = "The display_name of the group being managed."
  type        = string
  default     = "Project administrators"
}
variable "mail" {
  description = "The mail of the group being managed."
  type        = string
  default     = null
}
variable "members" {
  description = "list of user or group descriptors that will become members of the group"
  type        = list(string)
  default     = null
}
variable "origin_id" {
  description = "The origin_id of the group being managed."
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_group"
  type        = string
  default     = null
}
variable "scope" {
  description = "The scope of the group being managed."
  type        = string
  default     = null
}