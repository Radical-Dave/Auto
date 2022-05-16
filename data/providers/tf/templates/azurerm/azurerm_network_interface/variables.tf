variable "name" {
  description = "The name of the network interface"
  type = string
  default = ""
}
variable "location" {
  description = "The location of the network interface"
  type = string
  default = ""
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = ""
}
variable "network_security_group_id" {
  description = "The network_security_group_id of the network interface"
  type = list
  default = []
}
variable "ip_configuration" {
  description = "The ip_configuration for the network"
  type = list(map(any))
  # type = list(object({
  #   name = string
  #   gateway_load_balancer_frontend_ip_configuration_id = string
  #   subnet_id = string
  #   primary = string
  #   private_ip_address = string
  #   #private_ip_address_version = string
  #   private_ip_address_allocation = string
  #   public_ip_address_id = string
  # }))
  default = null
}
# variable "private_ip_address" {
#   description = "The private_ip_address of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
#   type = string
#   default = null
# }
# variable "private_ip_address_version" {
#   description = "The private_ip_address_version of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
#   type = string
#   default = null
# }
# variable "public_ip_address_id" {
#   description = "The public_ip_address_id of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
#   type = string
#   default = null
# }
variable "tags" {
  description = "Tags for the virtual network"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}