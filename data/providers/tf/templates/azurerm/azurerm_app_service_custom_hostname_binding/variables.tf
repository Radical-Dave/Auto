variable "domain" {
  description = "The domain of the AppService Plan"
  type = string
  default = null
}
variable "defaultdomain" {
  description = "The defaultdomain of the AppService Plan"
  type = string
  default = null
}
variable "prefix" {
  description = "The prefix of the hostname - appends to default hostname"
  type = string
  default = null
}
variable "hostname" {
  description = "The hostname of the AppService Plan"
  type = string
  default = null
}
variable "app_service_name" {
  description = "The tier of the AppService Plan"
  type = string
  default = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "location" {
  description = "The location of the resource group"
  type = string
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