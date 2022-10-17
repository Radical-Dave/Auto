variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "capacity" {
  description = "The capacity of the AppService Plan - (Free,Shared,Basic,Standard,Premium,PremiumV2,Isolated)"
  type        = number
  default     = 3
}
variable "tier" {
  description = "The tier of the AppService Plan - (Free,Shared,Basic,Standard,Premium,PremiumV2,Isolated)"
  type        = string
  default     = "Shared"
}
variable "size" {
  description = "The size of the AppService Plan (F1,D1,B1,B2,B3,P1v2)"
  type        = string
  default     = "D1"
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
variable "kind" {
  description = "The kind of the AppService Plan - (App elastic FunctionApp Linux Windows xenon)"
  type        = string
  default     = null
}
variable "reserved" {
  description = "The reserved of the AppService Plan"
  type        = bool
  default     = false
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
