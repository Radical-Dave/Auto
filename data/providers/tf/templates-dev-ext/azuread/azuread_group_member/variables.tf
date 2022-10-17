variable "group_object_id" {
  description = "The name of the azuread_group_member"
  type        = string
  default     = null
}
variable "users" {
  description = "The name of the azuread_group_member"
  type        = list(string)
  default     = null
}