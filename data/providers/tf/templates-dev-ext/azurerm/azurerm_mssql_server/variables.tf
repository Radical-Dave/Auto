variable "name" {
  description = "The name of the database server"
  type        = string
  default     = null
}
variable "dbserver_version" {
  description = "The version of the database server"
  type        = string
  default     = null
}
variable "dbserver_login" {
  description = "The login of the database server"
  type        = string
  default     = null
}
variable "dbserver_pwd" {
  description = "The password of the database server"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}
variable "vault_name" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = null
}
variable "vault_resource_group" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "base-terraform-rg"
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}