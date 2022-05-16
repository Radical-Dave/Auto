output "org_service_url" {
  description = "The org_service_url of the azuredevops_variable_group provisioned"
  value = "${azuredevops_variable_group.this.org_service_url}"
}
output "personal_access_token" {
  description = "The personal_access_token of the azuredevops_variable_group provisioned"
  value = "${azuredevops_variable_group.this.personal_access_token}"
}