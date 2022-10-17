variable "name" {
  description = "The name of the firewall"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the firewall"
  type        = string
}
variable "public_ip_address_id" {
  description = "The public_ip_address_id of the resource group"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "sku_name" {
  description = "The sku_name of the resource group - [AZFW_Hub,AZFW_VNet]"
  type        = string
  default     = "AZFW_VNet"
}
variable "sku_tier" {
  description = "The sku_tier of the resource group - [Standard,Premium]"
  type        = string
  default     = "Premium"
}
variable "subnet_id" {
  description = "The subnet_id of the resource group"
  type        = string
}
variable "addresses" {
  description = "The addresses of the firewall"
  type        = list(any)
  default     = ["10.0.0.0/16"]
}
# variable subnets {
#   description="Subnets for the firewall"
#   type=map(object({
#     name=string
#     address=string
#   }))
# }
variable "tags" {
  description = "Tags for the firewall"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}