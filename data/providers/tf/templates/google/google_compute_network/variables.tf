variable "auto_create_subnetworks" {
  description = "The auto_create_subnetworks for the google_compute_network - [Default: ami-0c55b159cbfafe1f0 - ubuntu 22.04]"
  type        = bool
  default     = false
}
variable "delete_default_routes_on_create" {
  description = "The delete_default_routes_on_create for the google_compute_network - [Default: ami-0c55b159cbfafe1f0 - ubuntu 22.04]"
  type        = bool
  default     = false
}
variable "description" {
  description = "The description for the google_compute_network"
  type        = string
  default     = null
}
variable "enable_ula_internal_ipv6" {
  description = "The enable_ula_internal_ipv6 for the google_compute_network - [Default: ami-0c55b159cbfafe1f0 - ubuntu 22.04]"
  type        = bool
  default     = false
}
variable "internal_ipv6_range" {
  description = "The internal_ipv6_range for the google_compute_network"
  type        = string
  default     = null
}
variable "mtu" {
  description = "The mtu for the google_compute_network - [Default t2.micro - 1 virtual cpu, 1gb ram]"
  type        = number
  default     = 1460
}
variable "name" {
  description = "The name for the google_compute_network"
  type        = string
  default     = null
}
variable "project" {
  description = "The project for the google_compute_network"
  type        = string
  default     = null
}
variable "routing_mode" {
  description = "The routing_mode for the google_compute_network [Global, Regional]"
  type        = string
  default     = null
}