variable "name" {
  description = "The name of the azurerm_dns_a_record"
  type        = string
  default     = null
}
variable "records" {
  description = "The record(s) of the azurerm_dns_a_record"
  type        = list(string)
  default     = null
}
variable "resource_group_name" {
  description = "The name of the azurerm_dns_a_record"
  type        = string
  default     = null
}
variable "tags" {
  description = "The tags for the azurerm_dns_a_record"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}
variable "ttl" {
  description = "The ttl of the azurerm_dns_a_record"
  type        = number
  default     = 30
}
variable "zone_name" {
  description = "The name of the azurerm_dns_a_record"
  type        = string
  default     = null
}