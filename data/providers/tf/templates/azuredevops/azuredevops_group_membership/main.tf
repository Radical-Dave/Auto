resource "azuredevops_group_membership" "this" {
  group = var.group
  members = var.members
}