variable "project_id" {
  description = "The project_id of the resource group"
  type = string
}
variable "repo_id" {
  description = "The repo_id of the resource group"
  type = string
}
variable "branch_name" {
  description = "The branch_name of the resource group"
  type = string
  default = null
}
variable "variable_groups" {
  description = "The variable_groups of the resource group"
  type = set(number)
  default = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "location" {
  description = "The location of the resource group"
  type = string
  default = "eastus"
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}