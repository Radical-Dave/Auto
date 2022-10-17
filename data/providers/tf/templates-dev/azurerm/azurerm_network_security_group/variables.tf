variable "name" {
  description = "The name of the network security group"
  type        = string
  default     = null
}
variable "asgs" {
  description = "The name of the application security group(s)"
  type        = list(string)
  default     = null
}
variable "nsg_rules" {
  description = "The name of the network security group"
  type = map(object({
    # name=string#optional(string)
    # location=string#optional(string)
    # resource_group_name=string#optional(string)
    # #access=string    
    # #destination_port_range=string
    # #destination_address_prefix=optional(string)
    # #destination_address_prefixes=optional(list(string))
    # destination_application_security_group_ids=list(string)#optional(list(string))
    # #direction=string
    # #priority=number
    # #protocol=string      
    # #source_port_range=string    
    # #source_address_prefix=string
    # #source_address_prefixes=optional(list(string))
    # source_application_security_group_ids=list(string)#optional(list(string))
  }))
  default = {}
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
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}