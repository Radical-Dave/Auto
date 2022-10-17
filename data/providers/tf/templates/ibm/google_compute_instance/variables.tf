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
variable "name" {
  description = "The name for the google_compute_instance"
  type        = string
}
variable "network_id" {
  description = "The network_id for the google_compute_instance"
  type        = list(string)
  default     = null
}
variable "priority" {
  description = "The priority for the google_compute_instance - Default: 1000]"
  type        = number
  default     = 1000
}
variable "source_ranges" {
  description = "The source_ranges for the google_compute_instance"
  type        = list(string)
  default     = null
}
variable "target_tags" {
  description = "The target_tags for the google_compute_instance"
  type        = list(string)
  default     = null
}
variable "zone" {
  description = "The priority for the google_compute_instance - [Default: us-central1 - us-east1,us-south1]"
  type        = string
  default     = "us-central1"
}