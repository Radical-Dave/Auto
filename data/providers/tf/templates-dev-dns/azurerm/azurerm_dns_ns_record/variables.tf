variable "name" {
  description = "The name of the dns record"
  type        = string
  default     = null
}
variable "records" {
  description = "The record(s) of the dns record"
  type        = list(string)
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "ttl" {
  description = "The ttl of the dns record"
  type        = number
  default     = null
}
variable "zone_name" {
  description = "The name of the dns record"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}