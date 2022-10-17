resource "google_compute_firewall" "this" {
  allow {
    ports    = var.allow_ports
    protocol = var.allow_protocol
  }
  direction     = var.direction
  name          = var.name
  network       = var.network_id
  priority      = var.priority
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
  #zone=var.zone
}