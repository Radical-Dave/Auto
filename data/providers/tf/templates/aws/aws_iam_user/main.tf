resource "aws_iam_user" "this" {
  force_destroy        = var.force_destroy
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
}