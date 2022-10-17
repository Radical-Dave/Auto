resource "aws_network_acl_rule" "this" {
  count           = var.rules != null ? length(var.rules) : 0
  network_acl_id  = var.network_acl_id
  egress          = var.egress
  rule_number     = var.rules[count.index]["rule_number"]
  rule_action     = var.rules[count.index]["rule_action"]
  from_port       = lookup(var.rules[count.index], "from_port", null)
  to_port         = lookup(var.rules[count.index], "to_port", null)
  icmp_code       = lookup(var.rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.rules[count.index], "icmp_type", null)
  protocol        = var.rules[count.index]["protocol"]
  cidr_block      = lookup(var.rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.rules[count.index], "ipv6_cidr_block", null)
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
}