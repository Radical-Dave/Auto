variable "allow_ports" {
  description = "The allow_ports for the google_compute_instance - [Default [22]]"
  type        = list(string)
  default     = ["22"]
}
variable "allow_protocol" {
  description = "The allow_protocol for the google_compute_instance - [Default: tcp]"
  type        = string
  default     = "tcp"
}
variable "direction" {
  description = "The direction for the google_compute_instance"
  type        = string
  default     = "INGRESS"
}
variable "disk_interface" {
  description = "The network_id for the google_compute_instance"
  type        = string
  default     = "SCSI"
}
variable "image" {
  description = "The image for the google_compute_instance"
  type        = string
  default     = "debian-cloud/debian-11"
}
variable "labels" {
  description = "The tags for the google_compute_instance"
  type        = map(string)
  default     = null
}
variable "machine_type" {
  description = "The machine_type for the google_compute_instance"
  type        = string
  default     = "f1-micro"
}
variable "metadata" {
  description = "The network_id for the google_compute_instance"
  type        = map(string)
  default     = null
}
variable "metadata_startup_script" {
  description = "The metadata_startup_script for the google_compute_instance"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the google_compute_instance"
  type        = string
  default     = null
}
variable "network" {
  description = "The network_id for the google_compute_instance"
  type        = string
  default     = null
}
variable "network_id" {
  description = "The network_id for the google_compute_instance"
  type        = string
  default     = null
}
variable "priority" {
  description = "The priority for the google_compute_instance - Default: 1000]"
  type        = number
  default     = 1000
}
variable "project" {
  description = "The project of the _instance"
  type        = string
  default     = null
}
variable "service_account_email" {
  description = "The service_account_email for the google_compute_instance - Default: 1000]"
  type        = string
  default     = null
}
variable "source_ranges" {
  description = "The source_ranges for the google_compute_instance"
  type        = list(string)
  default     = null
}
variable "subnetwork_id" {
  description = "The subnetwork_id for the google_compute_instance"
  type        = string
  default     = null
}
# variable tags {
#   description="The tags for the google_compute_instance"
#   type=list(string)
#   default=null
# }
# variable tags_default {
#   description="The tags_default for the google_compute_instance"
#   type=list(string)
#   default=null
# }
variable "zone" {
  description = "The priority for the google_compute_instance - [Default: us-central1 - us-east1,us-south1]"
  type        = string
  default     = "us-central1"
}