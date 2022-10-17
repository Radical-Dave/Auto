variable "allocation_method" {
  description = "The allocation method of the public ip. (Dynamic or Static)"
  type        = string
  default     = "Static"
}
# variable availability_zone {
#   description="The availability_zone of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
#   type=string
#   default="No-Zone" #"Zone-Redundant"
# }
variable "domain_name_label" {
  description = "The domain_name_label of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
  type        = string
  default     = null
}
variable "idle_timeout_in_minutes" {
  description = "The idle_timeout_in_minutes of the public ip. (4 - 30 minutes)"
  type        = number
  default     = 4
}
variable "ip_tags" {
  description = "The availability_zone of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
  type        = map(string)
  default     = {}
}
variable "ip_version" {
  description = "The ip version of the public ip. (IPv4 or ...)"
  type        = string
  default     = "IPv4"
}
variable "location" {
  description = "The location of the public ip"
  type        = string
  default     = "eastus"
}
variable "name" {
  description = "The name of the public ip"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The resourcegroup of the public ip"
  type        = string
}
variable "reverse_fqdn" {
  description = "The reverse_fqdn of the public ip. (Zone-Redundant, 1, 2, 3, or No-Zone)"
  type        = string
  default     = null
}
variable "sku" {
  description = "The sku of the public ip. (Basic or Standard)"
  type        = string
  default     = "Standard"
}
variable "sku_tier" {
  description = "The sku_tier of the public ip. (Global or Regional)"
  type        = string
  default     = "Regional"
}
variable "tags" {
  description = "Tags for the public ip"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}