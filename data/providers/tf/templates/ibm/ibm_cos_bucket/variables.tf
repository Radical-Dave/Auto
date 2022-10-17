variable "endpoint_type" {
  description = "The force_destroy for the ibm_cos_bucket - default: false"
  type        = string
  default     = "public"
}

variable "name" {
  description = "The name for the ibm_cos_bucket"
  type        = string
}
variable "resource_instance_id" {
  description = "The location for the ibm_cos_bucket - default: US"
  type        = string
}
variable "single_site_location" {
  description = "The location for the ibm_cos_bucket - default: US"
  type        = string
}
variable "region_location" {
  description = "The region_location for the ibm_cos_bucket - default: US"
  type        = string
}
variable "storage_class" {
  description = "The storage_class for the ibm_cos_bucket"
  type        = string
  default     = "STANDARD"
}