variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "defaultdomain" {
  description = "The defaultdomain of the web apps"
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
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}