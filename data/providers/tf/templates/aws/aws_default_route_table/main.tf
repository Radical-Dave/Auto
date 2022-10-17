locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_default_route_table" "this" {
  default_route_table_id = var.id
  propagating_vgws       = var.default_route_table_propagating_vgws
  dynamic "route" {
    for_each = var.default_route_table_routes
    content {
      # One of the following destinations must be provided
      cidr_block      = route.value.cidr_block
      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
      # One of the following targets must be provided
      egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id             = lookup(route.value, "gateway_id", null)
      instance_id            = lookup(route.value, "instance_id", null)
      nat_gateway_id         = lookup(route.value, "nat_gateway_id", null)
      network_interface_id   = lookup(route.value, "network_interface_id", null)
      transit_gateway_id     = lookup(route.value, "transit_gateway_id", null)
      # `vpc_endpoint_id` was recently added in v3.15.0
      # vpc_endpoint_id=lookup(route.value, "vpc_endpoint_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }
  tags = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}