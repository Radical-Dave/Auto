locals {
  name = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "${var.project != null ? var.project : "Blessed-Beyond-Foundation"}-subnetwork"), "/[^A-Za-z0-9]-/", ""))
}
resource "google_compute_subnetwork" "this" {
  ip_cidr_range = var.ip_cidr_range
  name          = local.name
  network       = var.network_id
  region        = var.region
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
  #zone=var.zone
}