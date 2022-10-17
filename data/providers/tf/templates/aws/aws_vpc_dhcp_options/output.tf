output "id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc_dhcp_options.this.*.id, [""])[0]
}