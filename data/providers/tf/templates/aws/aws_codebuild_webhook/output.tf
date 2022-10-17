output "id" {
  description = "The id of the aws_codebuild_project"
  value       = aws_codebuild_project.this.id
}
output "this" {
  description = "The aws_codebuild_project"
  value       = aws_codebuild_project.this
}