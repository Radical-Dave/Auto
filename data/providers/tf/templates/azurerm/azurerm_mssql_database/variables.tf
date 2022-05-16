variable "name" {
  description = "The name of the database"
  type = string
  default = null
}
variable "db_collation" {
  description = "The collation of the database"
  type = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}
variable "db_maxsize" {
  description = "The maxsize of the database (in gb)"
  type = string
  default = 4
}
variable "db_scale" {
  description = "The password of the database server"
  type = string
  default = true
}
variable "db_sku" {
  description = "The password of the database server"
  type = string
  default = "BC_Gen5_2"
}
variable "db_redundant" {
  description = "The password of the database server"
  type = bool
  default = true
}
variable "dbserver_id" {
  description = "The version of the database server"
  type = string
  default = null
}
variable "sa_endpoint" {
  description = "The endpoint of the storageaccount"
  type = string
}
variable "sa_key" {
  description = "The key of the storageaccount"
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
  default = null
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    environment = "dev"
    costcenter = "it"
  }
}