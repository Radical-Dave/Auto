variable "name" {
  description = "The name of the AppService Plan"
  type = string
  default = ""
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = ""
}
variable "defaultdomain" {
  description = "The default domain of the web apps"
  type = string
  default = null
}
variable "domain" {
  description = "The domain of the web apps"
  type = string
  default = ""
}
variable "hostname" {
  description = "The hostname of the AppService Plan"
  type = string
  default = ""
}
variable "tags" {
  description = "Tags for the resource group"
  type = map(string)
  default     = {
    environment = "dev"
    costcenter = "it"
  }
}