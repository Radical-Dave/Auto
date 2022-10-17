output "id" {
  description = "The id of the azuredevops_project provisioned"
  value       = azuredevops_project.this.id
}
output "process_template_id" {
  description = "The process_template_id of the azuredevops_project provisioned"
  value       = azuredevops_project.this.process_template_id
}
# output "project_url" {
#   value = azuredevops_project.this.url
# }