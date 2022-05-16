output "id" {
  description = "The id of the azuread_group provisioned"
  value = "${azuread_group.this.id}"
}
output "mail" {
  description = "The mail of the azuread_group provisioned"
  value = "${azuread_group.this.mail}"
}
output "object_id" {
  description = "The object_id of the azuread_group provisioned"
  value = "${azuread_group.this.object_id}"
}