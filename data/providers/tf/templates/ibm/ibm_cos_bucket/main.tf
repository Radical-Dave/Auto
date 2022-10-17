resource "ibm_cos_bucket" "this" {
  bucket_name          = var.name
  endpoint_type        = var.endpoint_type
  region_location      = var.region_location
  resource_instance_id = var.resource_instance_id
  single_site_location = var.single_site_location
  storage_class        = var.storage_class
}