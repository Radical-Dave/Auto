variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "prefix" {
  description = "The prefix of the hostname - appends to default hostname"
  type        = string
  default     = null
}
variable "dns_resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "defaultdomain" {
  description = "The default domain of the web apps"
  type        = string
  default     = null
}
variable "domain" {
  description = "The domain of the web apps"
  type        = string
  default     = null
}
variable "hostname" {
  description = "The hostname of the AppService Plan"
  type        = string
  default     = null
}
variable "record" {
  description = "The record(s) of the AppService Plan"
  #type=set(object({value=string}))
  #type=set(string)
  type = list(object({ value = string }))
  #default=null
}
variable "zone_name" {
  description = "The zone_name of the AppService Plan"
  type        = string
  default     = null
}
variable "ttl" {
  description = "The ttl of the AppService Plan"
  type        = number
  default     = 30
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}