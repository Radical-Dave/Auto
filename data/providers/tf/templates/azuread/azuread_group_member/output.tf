output "id" {
  description = "The id of the azuread_group_member provisioned"
  value = "${azuread_group_member.this.id}"
}