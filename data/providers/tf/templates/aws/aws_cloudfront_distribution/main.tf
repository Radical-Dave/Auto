locals {
  #name=replace((length(local.name) > 64 ? substr(local.name, 0,63) : local.name), " ", "-")
  name      = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
  region    = length(var.region != null ? var.region : "") > 0 ? var.region : ""
  origin_id = length(var.origin_id != null ? var.origin_id : "") > 0 ? var.origin_id : "${local.name}.${local.region}.amazonaws.com"
}
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.domain_name #"test-cdn.s3.amazonaws.com"
    origin_id   = local.origin_id #"test-cdn.s3.${data.aws_region.current.name}.amazonaws.com"
  }
  tags = merge({ "Name" = format("%s", local.name) }, var.tags, var.tags_default)
}