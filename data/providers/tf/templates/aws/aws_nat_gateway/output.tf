output "id" {
  description = "The ID of the aws_nat_gateway"
  value       = concat(aws_nat_gateway.this.*.id, [""])[0]
}