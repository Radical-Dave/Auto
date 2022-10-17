output "arn" {
  description = "The arn of the aws_iam_policy"
  value       = aws_iam_policy.this.arn
}
output "id" {
  description = "The id of the aws_iam_policy"
  value       = aws_iam_policy.this.id
}