output "id" {
  description = "The ID of the VPC"
  value       = concat(aws_network_acl_rule.this.*.id, [""])[0]
}