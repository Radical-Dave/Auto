resource "aws_db_subnet_group" "this" {
  name        = lower(var.name)
  description = var.description
  subnet_ids  = var.subnet_ids
  tags        = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}