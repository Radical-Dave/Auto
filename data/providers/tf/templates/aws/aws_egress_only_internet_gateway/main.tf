locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_egress_only_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}