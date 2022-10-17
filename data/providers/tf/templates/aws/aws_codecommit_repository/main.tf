locals {
  #name=replace((length(var.name) > 64 ? substr(var.name, 0,63) : var.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_codecommit_repository" "this" {
  default_branch  = "main"
  description     = var.description
  repository_name = local.name
  tags            = merge({ "Name" = format("%s", local.name) }, var.tags, var.tags_default)
}