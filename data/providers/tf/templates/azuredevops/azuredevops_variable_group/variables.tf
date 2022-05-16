variable "name" {
  description = "The location of the azuredevops_variable_group"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_variable_group"
  type = string
  default = null
}
variable "location" {
  description = "The location of the azuredevops_variable_group"
  type = string
  default = "eastus"
}
variable "version_control" {
  description = "The version_control of the azuredevops_variable_group"
  type = string
  default = "Git"
}
variable "visibility" {
  description = "The visibility of the azuredevops_variable_group"
  type = string
  default = "private"
}
variable "work_item_template" {
  description = "The work_item_template of the azuredevops_variable_group"
  type = string
  default = "Agile"
}
variable "description" {
  description = "The description of the azuredevops_variable_group"
  type = string
  default = null
}
variable "features" {
  description = "The features of the azuredevops_variable_group"
  type = string
  default = null
}

variable "tags" {
  description = "Tags for the azuredevops_variable_group"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}