terraform {
  experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" { 
  features {}
}
module "resourcegroup" {
  source = "../../templates/resourcegroup"
  resource_group_name = var.resource_group_name
  location = var.location
}
module "frontdoor" {
  source = "../../templates/frontdoor"
  resource_group_name = module.resourcegroup.name
  location = module.resourcegroup.location
  frontdoor_name = var.frontdoor_name
  frontdoor_location = var.frontdoor_location
  frontend_endpoint = var.frontend_endpoint
  frontdoor_backend = var.frontdoor_backend
  frontdoor_health_probe = var.frontdoor_health_probe
  frontdoor_loadbalancer = var.frontdoor_loadbalancer
  frontdoor_custom_rules = var.frontdoor_custom_rules
  frontdoor_routing_rules = var.frontdoor_routing_rules
  frontdoor_managed_rules = var.frontdoor_managed_rules
  frontdoor_policy_settings = var.frontdoor_policy_settings
}
#module "nsg" {
#  source = "../../templates/nsg"
#  nsg_name = var.nsg_name
#  resource_group_name = module.resourcegroup.name
#  location = module.resourcegroup.location
#}