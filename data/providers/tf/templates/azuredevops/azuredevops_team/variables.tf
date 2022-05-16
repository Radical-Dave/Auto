variable "administrators" {
  description = "The administrators of the azuredevops_team being managed."
  type = list(string)
  default = null
}
variable "description" {
  description = "The description of the azuredevops_team being managed."
  type = string
  default = null
}
variable "members" {
  description = "list of user or group descriptors that will become members of the group"
  type = list(string)
  default = null
}
variable "name" {
  description = "The name of the azuredevops_group"
  type = string
  default = null
}
variable "project_id" {
  description = "The project_id of the group being managed."
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_group"
  type = string
  default = null
}