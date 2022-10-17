output "arn" {
  description = "The arn of the aws_iam_role"
  value       = aws_iam_role.this.arn
}
output "id" {
  description = "The ID of the aws_iam_role"
  value       = aws_iam_role.this.id
}
output "name" {
  description = "The name of the aws_iam_role"
  value       = aws_iam_role.this.name
}