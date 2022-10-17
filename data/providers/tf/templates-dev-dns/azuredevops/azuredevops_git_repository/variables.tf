variable "project_id" {
  description = "The project_id of the resource group"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the azuredevops_git_repository"
  type        = string
}
variable "location" {
  description = "The location of the azuredevops_git_repository"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azuredevops_git_repository"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}