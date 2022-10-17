variable "ami" {
  description = "The ami (Amazon Machine Image) for the google_compute_firewall - [Default: ami-0c55b159cbfafe1f0 - ubuntu 22.04]"
  type        = string
  default     = "ami-08c40ec9ead489470"
}
variable "instance_type" {
  description = "The instance_type for the google_compute_firewall - [Default t2.micro - 1 virtual cpu, 1gb ram]"
  type        = string
  default     = "t2.micro"
}
variable "name" {
  description = "The name for the google_compute_firewall"
  type        = string
}
variable "security_groups" {
  description = "The security_groups for the google_compute_firewall"
  type        = list(string)
  default     = null
}
variable "tags_default" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the google_compute_firewall"
  type        = map(string)
  default     = {}
}