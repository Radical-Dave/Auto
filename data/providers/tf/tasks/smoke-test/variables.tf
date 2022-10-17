variable "docker_repo" {
  description = "The docker_repo of the web app"
  type        = string
  default     = null
}
variable "docker_app" {
  description = "The docker_app of the web app"
  type        = string
  default     = null
}
variable "dns_zone_name" {
  description = "The dns_zone_name of the web apps"
  type        = string
  default     = "project.com"
}
variable "dns_resource_group_name" {
  description = "The dns_zone_name of the web apps"
  type        = string
  default     = "DNS_Zone_RG"
}
variable "subscription_id" {
  description = "The subscription_id of the resource group"
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
variable "app_sp" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "azdevops"
}
variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default = {
    environment = "dev"
    costcenter  = "it"
  }
}
variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = null
}
variable "asgs" {
  description = "The name of the application security group(s)"
  type        = list(string)
  default     = ["~dmz", "~web", "~db"]
}
variable "nsg_rules" {
  description = "The name of the network security group"
  type = map(object({
    name                                       = optional(string)
    access                                     = optional(string)
    description                                = optional(string)
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
    direction                                  = optional(string)
    network_security_group_name                = optional(string)
    priority                                   = optional(number)
    protocol                                   = optional(string) #Tcp,Udp,Icmp,Esp,Ah,*
    resource_group_name                        = optional(string)
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
  }))
  default = {}
  # default={
  #   sql={
  #     name=""
  #     priority=100
  #     direction="Inbound"
  #     access="Allow"
  #     protocol="Tcp"
  #     source_port_range="*"
  #     #destination_port_range="1433"
  #     #source_address_prefix="SqlManagement"
  #     #destination_address_prefix="192.168.2.0/24"
  #     #source_address_prefix=      
  #   }
  #   http={
  #     name=""
  #     priority=101
  #     direction="Inbound"
  #     access="Allow"
  #     protocol="Tcp"
  #     source_port_range="*"
  #     destination_port_range="80" #443
  #     source_address_prefix="*"
  #     destination_address_prefix="192.168.2.0/24"
  #   }
  # }
}
variable "pip_name" {
  description = "The name of the public ip"
  type        = string
  default     = null
}
variable "vnet_name" {
  description = "The name of the application security group"
  type        = string
  default     = null
}
variable "vnet_subnets" {
  description = "Subnets for the vnet"
  type = map(object({
    name           = string
    address        = string
    security_group = optional(string)
  }))
  default = {}
  # default={
  #   "subnet1"={ name="TESTSUBNET", address="10.0.1.0/24" },
  #   "subnet2"={ name="TESTSUBNET1", address="10.0.2.0/24" },
  #   "subnet3"={ name="TESTSUBNET2", address="10.0.3.0/24" },
  # }
}
variable "subnet_address_prefix" {
  description = "The address_prefix of the subnet"
  type        = string
  default     = null
}
variable "subnet_address_prefixes" {
  description = "The address_prefixes of the subnet"
  type        = list(string)
  default     = null
}
variable "app_service_plan_name" {
  description = "The name of the application security group"
  type        = string
  default     = null
}
variable "dbserver_name" {
  description = "The name of the database server"
  type        = string
  default     = null
}
variable "dbserver_version" {
  description = "The version of the database server"
  type        = string
  default     = "12.0"
}
variable "dbserver_login" {
  description = "The login of the database server"
  type        = string
  default     = ""
}
variable "dbserver_pwd" {
  description = "The password of the database server"
  type        = string
  default     = ""
}
variable "db_name" {
  description = "The name of the database server"
  type        = string
  default     = null
}
variable "sa_name" {
  description = "The storageaccount of the database server"
  type        = string
  default     = null
}
variable "ip_configuration" {
  description = "The ip_configuration for the network"
  # type=list(object({
  #   name=string
  #   gateway_load_balancer_frontend_ip_configuration_id=string
  #   subnet_id=string
  #   primary=string
  #   private_ip_address=string
  #   #private_ip_address_version=string
  #   private_ip_address_allocation=string
  #   public_ip_address_id=string
  # }))
  type    = list(map(any))
  default = null
}
variable "defaultdomain" {
  description = "The default domain of the web apps"
  type        = string
  default     = null
}
variable "domain" {
  description = "The domain of the web apps"
  type        = string
  default     = null
}
variable "hostname" {
  description = "The hostname of the AppService Plan"
  type        = string
  default     = null
}
variable "record" {
  description = "The record(s) of the azurerm_dns_txt_record"
  type = set(object(
    {
      value = string
    }
  ))
  default = null
}
variable "address_space" {
  description = "The name of the resource group"
  type        = list(string)
}
variable "subnets" {
  description = "The subnet(s) of the network security group"
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