output "id" {
  description = "The ID of the aws_security_group"
  value       = aws_security_group.this.id
}
output "name" {
  description = "The name of the aws_security_group"
  value       = aws_security_group.this.name
}