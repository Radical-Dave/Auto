variable "force_destroy" {
  description = "The force_destroy for the google_storage_bucket - default: false"
  type        = bool
  default     = false
}
variable "location" {
  description = "The location for the google_storage_bucket - default: US"
  type        = string
  default     = "US"
}
variable "name" {
  description = "The name for the google_storage_bucket"
  type        = string
}
variable "storage_class" {
  description = "The storage_class for the google_storage_bucket"
  type        = string
  default     = "STANDARD"
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the google_storage_bucket"
  type        = map(string)
  default     = {}
}
variable "versioning_enabled" {
  description = "The versioning_enabled for the google_storage_bucket - default: false"
  type        = bool
  default     = false
}