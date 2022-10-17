terraform {
  #experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}
module "azurerm_resource_group" {
  source   = "../../templates/azurerm/azurerm_resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "azurerm_frontdoor_firewall_policy" {
  source              = "../../templates/azurerm/azurerm_frontdoor_firewall_policy"
  resource_group_name = module.azurerm_resource_group.name
  location            = var.location
  custom_rules        = var.frontdoor_custom_rules
  managed_rules       = var.frontdoor_managed_rules
}