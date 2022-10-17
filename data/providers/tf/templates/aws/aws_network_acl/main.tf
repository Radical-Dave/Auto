resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  tags       = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}