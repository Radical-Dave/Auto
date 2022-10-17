locals {
  #backend_bucket=replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "")>0 ? var.backend_bucket : "${local.name}-tfstate-bucket"),"{name}",local.name),"/[^A-Za-z0-9]-/","")
  name      = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  namespace = replace(replace((length(var.namespace != null ? var.namespace : "") > 0 ? var.namespace : "${local.name}-namespace"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
resource "github_repository" "this" {
  description = var.description
  name        = local.name
  private     = var.private
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
}