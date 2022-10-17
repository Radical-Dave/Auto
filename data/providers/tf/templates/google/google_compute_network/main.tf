locals {
  name = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "${var.project != null ? var.project : "Blessed-Beyond-Foundation"}-network"), "/[^A-Za-z0-9]-/", ""))
}
resource "google_compute_network" "this" {
  auto_create_subnetworks         = var.auto_create_subnetworks
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description                     = var.description
  enable_ula_internal_ipv6        = var.enable_ula_internal_ipv6
  internal_ipv6_range             = var.internal_ipv6_range
  mtu                             = var.mtu
  name                            = local.name
  project                         = var.project
  routing_mode                    = var.routing_mode
}