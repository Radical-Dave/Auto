locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_organizations_organization" "this" {
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  cidr_block                       = var.cidr
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  instance_tenancy                 = var.instance_tenancy
  tags                             = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}