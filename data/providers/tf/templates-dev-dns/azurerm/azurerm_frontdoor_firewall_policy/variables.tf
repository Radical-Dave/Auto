variable "name" {
  description = "The name of the frontdoor firewall policy"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the frontdoor firewall policy"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "enabled" {
  description = "The enabled property of the frontdoor firewall policy"
  type        = bool
  default     = true
}
variable "mode" {
  description = "The mode of the frontdoor firewall policy"
  type        = string
  default     = "Prevention"
}
variable "custom_rules" {
  description = "custom rules of the frontdoor firewall policy"
  default     = null
}
variable "managed_rules" {
  description = "managed rules of the frontdoor firewall policy"
  default     = {}
}
variable "redirect_url" {
  description = "The redirect_url of the frontdoor firewall policy"
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}