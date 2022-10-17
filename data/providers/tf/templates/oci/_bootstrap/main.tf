locals {
  #backend_bucket=replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "")>0 ? var.backend_bucket : "${local.name}-tfstate-bucket"),"{name}",local.name),"/[^A-Za-z0-9]-/","")
  name      = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  namespace = replace(replace((length(var.namespace != null ? var.namespace : "") > 0 ? var.namespace : "${local.name}-namespace"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
module "oci_objectstorage_bucket" {
  source    = "../oci_objectstorage_bucket"
  name      = local.name
  namespace = local.namespace
}