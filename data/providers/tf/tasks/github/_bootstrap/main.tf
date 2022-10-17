terraform {
}
provider "oci" {
  #project = "{{YOUR GCP PROJECT}}"
  region = "us-central1"
  #zone="us-central1-c"
}
module "bootstrap" {
  source = "../../../templates/oci/_bootstrap"
  name   = var.name
}