variable "nic_id" {
  description = "The id of the network interface"
  type = string
  default = ""
}
variable "nsg_id" {
  description = "The id of the network security group"
  type = string
  default = ""
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = ""
}
variable "tags" {
  description = "Tags for the virtual network"
  type = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}