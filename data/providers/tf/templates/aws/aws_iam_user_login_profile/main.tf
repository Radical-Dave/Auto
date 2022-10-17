resource "aws_iam_user_login_profile" "this" {
  password_reset_required = var.password_reset_required
  pgp_key                 = var.pgp_key
  user                    = var.user
}