variable "azdo_org_service_url" {
  description = "The azdo_org_service_url of the resource group"
  type = string
  default = null
}
variable "azdo_personal_access_token" {
  description = "The azdo_personal_access_token of the azuredevops_project"
  type = string
}
variable "name" {
  description = "The location of the azuredevops_project"
  type = string
  default = null
}
variable "description" {
  description = "The description of the azuredevops_project"
  type = string
  default = null
}
variable "features" {
  description = "The features of the azuredevops_project"
  type = map(string)
  default = {
    "boards" = "enabled"
    "repositories" = "enabled"
    "pipelines" = "enabled"
    "testplans" = "enabled"
    "artifacts" = "enabled"
  } 
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_project"
  type = string
  default = null
}
variable "location" {
  description = "The location of the azuredevops_project"
  type = string
  default = "eastus"
}
variable "version_control" {
  description = "The version_control of the azuredevops_project"
  type = string
  default = "Git"
}
variable "visibility" {
  description = "The visibility of the azuredevops_project"
  type = string
  default = "private"
}
variable "work_item_template" {
  description = "The work_item_template of the azuredevops_project"
  type = string
  default = "Agile"
}


variable "tags" {
  description = "Tags for the azuredevops_project"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}