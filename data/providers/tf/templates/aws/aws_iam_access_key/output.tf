# output "create_date" {
#   description="The create_date of the aws_iam_access_key"
#   value=aws_iam_access_key.this.create_date
# }
output "encrypted_secret" {
  description = "The encrypted_secret of the aws_iam_access_key"
  value       = aws_iam_access_key.this.encrypted_secret
}
# output "encrypted_ses_smtp_password_v4" {
#   description="The encrypted_ses_smtp_password_v4 of the aws_iam_access_key"
#   value=aws_iam_access_key.this.encrypted_ses_smtp_password_v4
# }
output "id" {
  description = "The ID of the aws_iam_access_key"
  value       = aws_iam_access_key.this.id
}
output "key_fingerprint" {
  description = "The key_fingerprint of the aws_iam_access_key"
  value       = aws_iam_access_key.this.key_fingerprint
}
output "secret" {
  description = "The secret of the aws_iam_access_key"
  value       = aws_iam_access_key.this.secret
}
# output "ses_smtp_password_v4" {
#   description="The ses_smtp_password_v4 of the aws_iam_access_key"
#   value=aws_iam_access_key.this.ses_smtp_password_v4
# }