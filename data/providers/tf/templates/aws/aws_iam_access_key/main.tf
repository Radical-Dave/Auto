resource "aws_iam_access_key" "this" {
  pgp_key = var.pgp_key
  status  = var.status
  user    = var.user
}