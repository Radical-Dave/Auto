output "encrypted_password" {
  description = "The encrypted_password of the aws_iam_user_login_profile"
  value       = aws_iam_user_login_profile.this.encrypted_password
}
output "id" {
  description = "The ID of the aws_iam_user_login_profile"
  value       = aws_iam_user_login_profile.this.id
}
output "key_fingerprint" {
  description = "The key_fingerprint of the aws_iam_user_login_profile"
  value       = aws_iam_user_login_profile.this.key_fingerprint
}
# output "password" {
#   description="The password of the aws_iam_user_login_profile"
#   value=aws_iam_user_login_profile.this.password
# }