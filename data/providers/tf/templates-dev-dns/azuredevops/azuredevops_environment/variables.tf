variable "project_id" {
  description = "The project_id of the azuredevops_serviceendpoint_dockerregistry"
  type        = string
}
variable "name" {
  description = "The project_id of the azuredevops_serviceendpoint_dockerregistry"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the azuredevops_environment"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the azuredevops_environment"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}