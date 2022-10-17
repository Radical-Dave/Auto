#data "oci_identity_regions" "global" { }
# module oci_identity_region_subscriptions {
#   source="../oci_identity_region_subscriptions"
#   tenancy_ocid=var.tenancy_ocid
# }
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid != null ? var.tenancy_ocid : data.oci_identity_tenancy.account != null ? data.oci_identity_tenancy.account : ""
}
data "oci_identity_tenancy" "account" {
  tenancy_id = var.tenancy_ocid != null ? var.tenancy_ocid : ""
}
module "write_files" {
  source = "../../../templates/local/write_files"
  files  = { "debug.txt" = "ads=${data.oci_identity_availability_domains.ads.availability_domains}\naccount=${data.oci_identity_tenancy.account.id}\ntenancy_ocid=${var.tenancy_ocid != null ? var.tenancy_ocid : ""}" }
}
