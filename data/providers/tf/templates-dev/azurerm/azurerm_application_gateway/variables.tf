variable "name" {
  description = "The name of the azurerm_application_gateway"
  type        = string
  default     = null
}
variable "location" {
  description = "The location of the azurerm_application_gateway"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "retention_in_days" {
  description = "The retention_in_days of the resource group"
  type        = number
  default     = 100
}
variable "address_space" {
  description = "The address_space of the azurerm_application_gateway"
  type        = list(string)
}
# variable backend_address_prefix" {
#   description="The name of the resource group"
#   type=string
# }
# variable frontend_address_prefix" {
#   description="The name of the resource group"
#   type=string
# }
variable "subnets" {
  description = "The subnet(s) of the azurerm_application_gateway"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = [{
    name             = "frontend"
    address_prefixes = ["10.254.0.0/24"]
    }, {
    name             = "backend"
    address_prefixes = ["10.254.2.0/24"]
  }]
}
variable "sku" {
  description = "The sku(s) of the network security group"
  type = list(object({
    name     = string
    tier     = string
    capacity = number
  }))
  default = [{
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }]
}
variable "gateway_ip_configuration" {
  description = "The gateway_ip_configuration(s) of the network security group"
  type = list(object({
    name      = string
    subnet_id = string
  }))
  default = [{
    name      = "gateway_ip_configuration"
    subnet_id = ""
  }]
}
variable "frontend_port" {
  description = "The frontend_port(s) of the network security group"
  type = list(object({
    name = string
    port = number
  }))
  default = [{
    name = ""
    port = 80
  }]
}
variable "frontend_ip_configuration" {
  description = "The frontend_ip_configuration(s) of the network security group"
  type = list(object({
    name     = string
    tier     = string
    capacity = number
  }))
  default = [{
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }]
}
variable "backend_address_pool" {
  description = "The backend_address_pool(s) of the network security group"
  type = list(object({
    name     = string
    tier     = string
    capacity = number
  }))
  default = [{
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }]
}
variable "backend_http_settings" {
  description = "The backend_http_settings(s) of the network security group"
  type = list(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
  }))
  default = [{
    name                  = ""
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }]
}
variable "http_listener" {
  description = "The http_listener(s) of the network security group"
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
  default = [{
    name                           = "dev-feport" #${azurerm_virtual_network.example.name}-feport
    frontend_ip_configuration_name = "dev-feip"
    frontend_port_name             = "dev-feport" #${azurerm_virtual_network.example.name}-feport
    protocol                       = "Http"
  }]
}
variable "request_routing_rule" {
  description = "The request_routing_rule(s) of the network security group"
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
  default = [{
    name                       = "dev-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "dev-httplstn"
    backend_address_pool_name  = "dev-beap"
    backend_http_settings_name = "dev-behs"
    priority                   = 1
  }]
}
variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default = {
    costcenter = "it"
  }
}