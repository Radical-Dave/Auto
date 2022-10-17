locals {
  name           = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  backend_bucket = replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "") > 0 ? var.backend_bucket : "${local.name}-tfstate-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
module "google_storage_bucket" {
  source = "../google_storage_bucket"
  name   = local.backend_bucket
}
