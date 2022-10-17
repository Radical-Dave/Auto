resource "aws_iam_user_group_membership" "this" {
  user   = var.user
  groups = var.groups
}