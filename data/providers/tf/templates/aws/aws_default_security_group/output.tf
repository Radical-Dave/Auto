output "id" {
  description = "The ID of the aws_default_security_group"
  value       = concat(aws_default_security_group.this.*.id, [""])[0]
}