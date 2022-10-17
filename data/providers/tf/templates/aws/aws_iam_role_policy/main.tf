resource "aws_iam_role_policy" "this" {
  name   = var.name
  policy = var.policy
  role   = var.role
}