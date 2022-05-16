variable "project_id" {
  description = "The project_id of the azuredevops_project_pipeline_settings"
  type = string
}
variable "name" {
  description = "The project_id of the azuredevops_project_pipeline_settings"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The name of the azuredevops_project_pipeline_settings"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the azuredevops_project_pipeline_settings"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}