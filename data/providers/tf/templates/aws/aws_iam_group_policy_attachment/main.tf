resource "aws_iam_group_policy_attachment" "this" {
  group      = var.name
  policy_arn = var.policy_arn
}