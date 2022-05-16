output "id" {
  description = "The id of the azuredevops_build_definition provisioned"
  value = "${azuredevops_build_definition.this.id}"
}
# output "location" {
#   description = "The location of the azuredevops_build_definition provisioned"
#   value = "${azuredevops_build_definition.this.location}"
# }
output "name" {
  description = "The name of the azuredevops_build_definition provisioned"
  value = "${azuredevops_build_definition.this.name}"
}