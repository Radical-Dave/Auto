resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
  #tags=var.tags
}