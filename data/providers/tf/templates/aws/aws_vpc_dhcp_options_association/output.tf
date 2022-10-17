output "id" {
  description = "The ID of the aws_vpc_dhcp_options_association"
  value       = concat(aws_vpc_dhcp_options_association.this.*.id, [""])[0]
}