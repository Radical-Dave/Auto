resource "aws_route" "this" {
  route_table_id              = var.route_table_id
  destination_cidr_block      = var.cidr
  destination_ipv6_cidr_block = var.destination_ipv6_cidr_block
  gateway_id                  = var.gateway_id
  timeouts {
    create = "5m"
  }
  tags = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}