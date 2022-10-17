output "id" {
  description = "The ID of the aws_db_subnet_group"
  value       = concat(aws_db_subnet_group.this.*.id, [""])[0]
}