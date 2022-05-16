output "org_service_url" {
  description = "The org_service_url of the azuredevops_serviceendpoint_dockerregistry provisioned"
  value = "${azuredevops_serviceendpoint_dockerregistry.this.org_service_url}"
}
output "personal_access_token" {
  description = "The personal_access_token of the azuredevops_serviceendpoint_dockerregistry provisioned"
  value = "${azuredevops_serviceendpoint_dockerregistry.this.personal_access_token}"
}