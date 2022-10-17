resource "aws_default_vpc" "this" {
  enable_classiclink   = var.enable_classiclink
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}