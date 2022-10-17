resource "aws_vpc_dhcp_options_association" "this" {
  count           = var.create_vpc && var.enable_dhcp_options ? 1 : 0
  vpc_id          = local.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}