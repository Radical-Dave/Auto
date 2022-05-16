variable "project_id" {
  description = "The project_id of the azuredevops_serviceendpoint_dockerregistry"
  type = string
}
variable "docker_email" {
  description = "The docker_email of the azuredevops_serviceendpoint_dockerregistry"
  type = string
  default = null
}
variable "docker_username" {
  description = "The docker_username of the azuredevops_serviceendpoint_dockerregistry"
  type = string
  default = null
}
variable "docker_password" {
  description = "The docker_password of the azuredevops_serviceendpoint_dockerregistry"
  type = string
  default = null
}
variable "name" {
  description = "The name of the azuredevops_serviceendpoint_dockerregistry"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The resource_group_name of the azuredevops_serviceendpoint_dockerregistry"
  type = string
  default = null
}
variable "registry_type" {
  description = "The registry_type of the azuredevops_serviceendpoint_dockerregistry"
  type        = string
  default     = "DockerHub"
}
variable "tags" {
  description = "Tags for the azuredevops_serviceendpoint_dockerregistry"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}
