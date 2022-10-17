output "arn" {
  description = "The arn of the aws_codecommit_repository"
  value       = aws_codecommit_repository.this.arn
}
output "clone" {
  value = "git clone codecommit::${var.region}://${aws_codecommit_repository.this.repository_name}-pipeline"
}
output "id" {
  description = "The id of the aws_codecommit_repository"
  value       = aws_codecommit_repository.this.id
}
output "this" {
  description = "The aws_codecommit_repository"
  value       = aws_codecommit_repository.this
}