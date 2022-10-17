#data "oci_identity_regions" "global" { }
# module oci_identity_region_subscriptions {
#   source="../oci_identity_region_subscriptions"
#   tenancy_ocid=var.tenancy_ocid
# }
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}