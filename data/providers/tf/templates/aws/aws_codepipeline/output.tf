output "id" {
  description = "The id of the aws_codepipeline"
  value       = aws_codepipeline.this.id
}
output "this" {
  description = "The aws_codepipeline"
  value       = aws_codepipeline.this
}