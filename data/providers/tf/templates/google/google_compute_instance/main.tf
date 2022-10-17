locals {
  name = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "${var.project != null ? var.project : "Blessed-Beyond-Foundation"}-instance"), "/[^A-Za-z0-9]-/", ""))
}
resource "google_compute_instance" "this" {
  boot_disk {
    initialize_params {
      image  = var.image
      labels = var.labels
    }
  }
  machine_type            = var.machine_type
  metadata                = var.metadata
  metadata_startup_script = var.metadata_startup_script
  network_interface {
    access_config {
      # include to give VM external IP
    }
    network    = var.network
    subnetwork = var.subnetwork_id

  }
  name = local.name
  scratch_disk {
    interface = var.disk_interface
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
  zone = var.zone
}