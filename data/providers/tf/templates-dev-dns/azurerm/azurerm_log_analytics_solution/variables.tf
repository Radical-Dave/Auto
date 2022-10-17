variable "name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "plan" {
  description = "The plan of the log analytics solution"
  type = object({
    publisher = string
    product   = string
    #promotion_code=string
  })
  default = {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureAppGatewayAnalytics"
  }
}
variable "workspace_resource_id" {
  description = "The workspace_resource_id of the resource group"
  type        = string
}
variable "workspace_name" {
  description = "The workspace_name of the resource group"
  type        = string
  default     = "PerGB2018"
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}