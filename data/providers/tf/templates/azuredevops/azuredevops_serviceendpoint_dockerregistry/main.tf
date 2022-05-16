locals {
  name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0,63) : var.resource_group_name), " ", "-")
}
resource "azuredevops_serviceendpoint_dockerregistry" "this" {
  project_id = var.project_id
  service_endpoint_name = local.name
  docker_username = var.docker_user
  docker_email = var.docker_email
  docker_password = var.docker_password
  registry_type = var.registry_type
  description = var.description
}