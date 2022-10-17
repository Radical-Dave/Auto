resource "google_storage_bucket" "this" {
  force_destroy = var.force_destroy
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
  versioning { enabled = var.versioning_enabled }
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
}