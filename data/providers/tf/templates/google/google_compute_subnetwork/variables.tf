variable "ip_cidr_range" {
  description = "The ami (Amazon Machine Image) for the google_compute_subnetwork - [Default: ami-0c55b159cbfafe1f0 - ubuntu 22.04]"
  type        = string
  default     = null
}
variable "region" {
  description = "The instance_type for the google_compute_subnetwork - [Default t2.micro - 1 virtual cpu, 1gb ram]"
  type        = string
  default     = null
}
variable "name" {
  description = "The name for the google_compute_subnetwork"
  type        = string
  default     = null
}
variable "project" {
  description = "The project of the _instance"
  type        = string
  default     = null
}
variable "network_id" {
  description = "The network for the google_compute_subnetwork"
  type        = string
  default     = null
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the google_compute_subnetwork"
  type        = map(string)
  default     = {}
}