variable "name" {
  description = "The name of the AppService Plan"
  type        = string
  default     = null
}
variable "sku" {
  description = "The sku/ize of the AppService Plan (B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, and WS3.)"
  type        = string
  default     = "Y1"
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