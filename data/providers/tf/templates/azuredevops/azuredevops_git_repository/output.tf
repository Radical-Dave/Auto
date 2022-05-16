output "id" {
  description = "The id of the azuredevops_git_repository provisioned"
  value = "${azuredevops_git_repository.this.id}"
}
# output "location" {
#   description = "The location of the azuredevops_git_repository provisioned"
#   value = "${azuredevops_git_repository.this.location}"
# }
output "name" {
  description = "The name of the azuredevops_git_repository provisioned"
  value = "${azuredevops_git_repository.this.name}"
}