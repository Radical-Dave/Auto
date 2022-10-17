locals {
  #name=replace((length(local.name) > 64 ? substr(local.name, 0,63) : local.name), " ", "-")
  name = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
}
resource "aws_appconfig_application" "this" {
  name        = local.name
  description = var.description
  tags        = merge({ "Name" = format("%s", local.name) }, var.tags, var.tags_default)
}