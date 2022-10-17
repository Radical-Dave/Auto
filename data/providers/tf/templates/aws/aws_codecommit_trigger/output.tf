output "id" {
  description = "The id of the aws_codecommit_repository"
  value       = aws_codecommit_repository.this.id
}
output "this" {
  description = "The aws_codecommit_repository"
  value       = aws_codecommit_repository.this
}