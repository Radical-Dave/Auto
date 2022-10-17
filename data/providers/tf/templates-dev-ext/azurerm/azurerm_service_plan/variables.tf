variable "kind" {
  description = "The kind of the AppService Plan - (App elastic FunctionApp Linux Windows xenon)"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}
variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "os_type" {
  description = "The os_type of the AppService Plan - (Linux, Windows and WindowsContainer)"
  type        = string
  default     = null
}
variable "reserved" {
  description = "The reserved of the AppService Plan"
  type        = bool
  default     = false
}
variable "sku_name" {
  description = "The sku_name of the AppService Plan (F1,D1,B1,B2,B3,P1v2)"
  type        = string
  default     = "P1v2"
}
variable "resource_group_name" {
  description = "The name of the resource group"
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
variable "timeouts" {
  description = "nested mode: NestingSingle, min items: 0, max items: 0"
  type = set(object(
    {
      create = string
      delete = string
      read   = string
      update = string
    }
  ))
  default = []
}
variable "worker_count" {
  description = "The worker_count of the AppService"
  type        = number
  default     = 3
}