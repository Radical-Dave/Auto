variable "network_interface_id" {
  description = "The id of the network interface"
  type        = string
  default     = null
}
variable "application_security_group_id" {
  description = "The id of the application security group"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}