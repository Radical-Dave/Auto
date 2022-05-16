variable "resource_group_name" {
  description = "The name of the azuredevops_serviceendpoint_github"
  type        = string
}
variable "location" {
  description = "The location of the azuredevops_serviceendpoint_github"
  type        = string
  default     = "eastus"
}
variable "tags" {
  description = "Tags for the azuredevops_serviceendpoint_github"
  type        = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}