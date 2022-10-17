variable "bucket_access_type" {
  description = "The bucket_access_type for the oci_objectstorage_object - default: NoPublicAccess"
  type        = string
  default     = "NoPublicAccess"
}
variable "bucket_auto_tiering" {
  description = "The bucket_auto_tiering for the oci_objectstorage_object - default: false"
  type        = string
  default     = "Disabled"
}
variable "bucket_versioning" {
  description = "The bucket_versioning for the oci_objectstorage_object - default: false"
  type        = bool
  default     = false
}
variable "compartment_id" {
  description = "The compartment_id for the oci_objectstorage_object - default: US"
  type        = string
  default     = "US"
}
variable "defined_tags" {
  description = "Additional defined_tags for the oci_objectstorage_object"
  type        = map(string)
  default     = {}
}
variable "freeform_tags" {
  description = "Additional freeform_tags for the oci_objectstorage_object"
  type        = map(string)
  default     = {}
}
variable "kms_key_id" {
  description = "The compartment_id for the oci_objectstorage_object - default: US"
  type        = string
  default     = "US"
}
variable "metadata" {
  description = "Additional metadata for the oci_objectstorage_object"
  type        = map(string)
  default     = {}
}
variable "name" {
  description = "The name for the oci_objectstorage_object"
  type        = string
}
variable "namespace" {
  description = "The namespace for the oci_objectstorage_object"
  type        = string
}
variable "object_events_enabled" {
  description = "The object_events_enabled for the oci_objectstorage_object - default: false"
  type        = bool
  default     = false
}
variable "storage_tier" {
  description = "The storage_tier for the oci_objectstorage_object"
  type        = string
  default     = "STANDARD"
}
variable "retention_rule_display_name" {
  description = "The storage_tier for the oci_objectstorage_object"
  type        = string
  default     = null
}
variable "retention_rule_duration_time_amount" {
  description = "The storage_tier for the oci_objectstorage_object"
  type        = string
  default     = "STANDARD"
}
variable "retention_rule_duration_time_unit" {
  description = "The storage_tier for the oci_objectstorage_object"
  type        = string
  default     = "STANDARD"
}
variable "retention_rule_time_rule_locked" {
  description = "The retention_rule_time_rule_locked for the oci_objectstorage_object"
  type        = string
  default     = "STANDARD"
}
variable "versioning_enabled" {
  description = "The versioning_enabled for the oci_objectstorage_object - default: false"
  type        = bool
  default     = false
}