output "id" {
  description = "The ID of the aws_vpc_ipv4_cidr_block_association"
  value       = concat(aws_vpc_ipv4_cidr_block_association.this.*.id, [""])[0]
}