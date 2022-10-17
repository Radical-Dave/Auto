variable "group" {
  description = "The group of the group being managed."
  type        = string
}
variable "mode" {
  description = "The mode of the group being managed."
  type        = string
  default     = null
}
variable "members" {
  description = "list of user or group descriptors that will become members of the group"
  type        = list(string)
  default     = null
}