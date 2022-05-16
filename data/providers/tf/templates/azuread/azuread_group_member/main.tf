resource "azuread_group_member" "this" {
  #for_each = { for u in var.users: u.mail_nickname => u if u.job_title == "Manager" }
  for_each = { for u in var.users: u.principal => u }
  group_object_id  = var.group_object_id
  member_object_id = each.value.id 
}