variable "name" {
  description = "The name of the dns record"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "zone_name" {
  description = "The name of the dns record"
  type = string
  default = null
}
variable "record" {
  description = "The record(s) of the dns record"
  type = set(object(
    {
      value = string
    }
  ))
  default = null
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}