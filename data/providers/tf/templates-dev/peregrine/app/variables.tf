variable "ADDRESS_SPACE" {
  description = "The ADDRESS_SPACE of the azurerm_virtual_network"
  type        = list(string)
  #default=null
  default = ["10.0.0.0/16"]
}
variable "API" {
  description = "The api of the web app"
  type        = string
  default     = "vantage-core-api"
}
variable "APP" {
  description = "The app of the web app"
  type        = string
  default     = "vantage-ng-app"
}
variable "app_service_plan_name" {
  description = "The app_service_plan_name of the application security group"
  type        = string
  default     = null
}
variable "APP_SP" {
  description = "The APP_SP of app serviceprincipal of the resource group"
  type        = string
  default     = "azdevops"
}
variable "asgs" {
  description = "The asgs of the application security group(s)"
  type        = set(string)
  default     = ["~api", "~db", "~web"]
}
variable "AUTH0_CLIENT_ID" {
  description = "The AUTH0_CLIENT_ID for auth0"
  type        = string
}
variable "AUTH0_CLIENT_SECRET" {
  description = "The AUTH0_CLIENT_SECRET for auth0"
  type        = string
}
variable "AUTH0_DOMAIN" {
  description = "The AUTH0_DOMAIN for auth0"
  type        = string
  default     = "project-dev.us.auth0.com"
}
variable "AUTH0_ORGANIZATION_ID" {
  description = "The AUTH0_ORGANIZATION_ID for auth0"
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
  default     = null
}
variable "dbserver_pwd" {
  description = "The password of the database server"
  type        = string
  default     = null
}
variable "db_name" {
  description = "The name of the database server"
  type        = string
  default     = null
}
variable "DOCKER_IMAGE_TAGS" {
  description = "The DOCKER_IMAGE_TAGS of the web app"
  type        = string
  default     = "dev,demo,qa,test,www"
}
variable "DOCKER_NAME" {
  description = "The docker_name of the web app"
  type        = string
  default     = null
}
variable "DOCKER_PASSWORD" {
  description = "The docker_password of the web app"
  type        = string
  default     = null
}
variable "DOCKER_REGISTRY" {
  description = "The docker_registry of the web app"
  type        = string
  default     = null
}
variable "DOCKER_USERNAME" {
  description = "The DOCKER_USERNAME of the web app"
  type        = string
  default     = null
}
variable "DNS_DOMAIN" {
  description = "The default domain of the web apps"
  type        = string
  default     = "project.com"
}
variable "DNS_DOMAIN_AZURE" {
  description = "The default domain of the web apps"
  type        = string
  default     = "azurewebsites.net"
}
variable "DNS_RESOURCE_GROUP_NAME" {
  description = "The DNS_RESOURCE_GROUP_NAME of the web apps"
  type        = string
  default     = "DNS_Zone_RG"
}
variable "ENVNAME" {
  description = "The env of the web app"
  type        = string
  default     = null
}
variable "HOST" {
  description = "The HOST of the AppService Plan"
  type        = string
  default     = null
}
variable "HOSTNAME" {
  description = "The HOSTNAME of the AppService Plan"
  type        = string
  default     = null
}
variable "FTP_projectPAY_PRGRIN_FTPPASSWORD" {
  description = "The FTP_projectPAY_PRGRIN_FTPPASSWORD of the web app"
  type        = string
  default     = null
}
variable "FTP_projectPAY_PRGRIN_FTPUSERNAME" {
  description = "The FTP_projectPAY_PRGRIN_FTPUSERNAME of the web app"
  type        = string
  default     = null
}
variable "FTP_projectPAY_URI" {
  description = "The FTP_projectPAY_URI of the web app"
  type        = string
  default     = "ftp.projectpay.com"
}
variable "FTP_PHICURE_PRGRIN_FTPPASSWORD" {
  description = "The phicure_password of the web app"
  type        = string
  default     = null
}
variable "FTP_PHICURE_PRGRIN_FTPUSERNAME" {
  description = "The phicure_username of the web app"
  type        = string
  default     = null
}
variable "FTP_PHICURE_PORT" {
  description = "The phicure_username of the web app"
  type        = string
  default     = "22"
}
variable "FTP_PHICURE_URI" {
  description = "The phicure_uri of the web app"
  type        = string
  default     = "sftp.phicure.com"
}
variable "FUNCTION_APP_REPO" {
  description = "The FUNCTION_APP_REPO of the web app"
  type        = string
  default     = "https://IPAZDOTestRun@dev.azure.com/IPAZDOTestRun/IPAZDOTestRun/_git/project-sched-func"
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
variable "LOCATION" {
  description = "The location of the resource group"
  type        = string
  default     = "eastus"
}
variable "nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = null
}
variable "nsg_rules" {
  description = "The name of the network security group"
  # type=map(object({
  #   name=string#optional(string)
  #   access=string#optional(string)
  #   description=string#optional(string)
  #   destination_port_range=string#optional(string)
  #   destination_port_ranges=list(string)#optional(list(string))
  #   destination_address_prefix=string#optional(string)
  #   destination_address_prefixes=list(string)#optional(list(string))
  #   destination_application_security_group_ids=list(string)#optional(list(string))
  #   direction=string#optional(string)
  #   network_security_group_name=string#optional(string)
  #   priority=number#optional(number)
  #   protocol=string#optional(string) #Tcp,Udp,Icmp,Esp,Ah,*
  #   resource_group_name=string#optional(string)
  #   source_port_range=string#optional(string)
  #   source_port_ranges=list(string)#optional(list(string))
  #   source_address_prefix=string#optional(string)
  #   source_address_prefixes=list(string)#optional(list(string))
  #   source_application_security_group_ids=list(string)#optional(list(string))
  # }))
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
variable "PREFIX" {
  description = "The prefix of the web app"
  type        = string
  default     = null
}
variable "project_API_KEY" {
  description = "The project_API_KEY of the resource group"
  type        = string
  default     = null
}
variable "project_API_AUDIENCE" {
  description = "The project_API_AUDIENCE of the resource group"
  type        = string
  default     = null
}
variable "project_API_AUTHORITY" {
  description = "The project_API_AUTHORITY of the resource group"
  type        = string
  default     = "https://project-dev.us.auth0.com"
}
variable "project_API_CLIENT_ID" {
  description = "The project_API_CLIENT_ID of the resource group"
  type        = string
  default     = null
}
variable "project_API_CLIENT_SECRET" {
  description = "The project_API_CLIENT_SECRET of the resource group"
  type        = string
  default     = null
}
variable "project_API_ORIGINS" {
  description = "The project_API_ORIGINS of the resource group"
  type        = string
  default     = null
}
# variable project_ADMIN_API_CLIENT_ID {
#   description="The project_API_CLIENT_ID of the resource group"
#   type=string
#   default=null
# }
# variable project_ADMIN_API_CLIENT_SECRET {
#   description="The project_API_CLIENT_SECRET of the resource group"
#   type=string
#   default=null
# }
variable "record" {
  description = "The record(s) of the azurerm_dns_txt_record"
  type = set(object(
    {
      value = string
    }
  ))
  default = null
}
variable "RESOURCE_GROUP_NAME" {
  description = "The name of the resource group"
  type        = string
  default     = null
}
variable "sa_name" {
  description = "The storageaccount of the database server"
  type        = string
  default     = null
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
variable "SUBNETS" {
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
variable "SUBSCRIPTION_ID" {
  description = "The subscription_id of the resource group"
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
variable "VAULT_NAME" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = null
}
variable "VAULT_RESOURCE_GROUP" {
  description = "The name of app serviceprincipal of the resource group"
  type        = string
  default     = "base-terraform-rg"
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
    security_group = string #optional(string)
  }))
  default = {}
  # default={
  #   "subnet1"={ name="TESTSUBNET", address="10.0.1.0/24" },
  #   "subnet2"={ name="TESTSUBNET1", address="10.0.2.0/24" },
  #   "subnet3"={ name="TESTSUBNET2", address="10.0.3.0/24" },
  # }
}
variable "URLS" {
  description = "The URLS of the resource group"
  type        = string
  default     = null
}
variable "zone_name" {
  description = "The zone_name of the web apps"
  type        = string
  default     = null
}