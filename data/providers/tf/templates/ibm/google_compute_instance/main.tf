resource "google_compute_instance" "this" {
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  machine_type            = var.machine_type
  metadata_startup_script = var.metadata_startup_script
  network_interface {
    subnetwork = var.subnetwork_id
    access_config {
      # include to give VM external IP
    }
  }
  name = var.name
  tags = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
  zone = var.zone
}