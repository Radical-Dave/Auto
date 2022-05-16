terraform {
  experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    container_name  = "smoke-test-terraform"
    key = "smoke-test-terraform.tfstate"      
  }
}
provider "azurerm" { 
  subscription_id = var.subscription_id
  features {}
}
#resource "azurerm_resource_group" "legacy-resource-group" {}

module "azurerm_resource_group" {
  source = "../../templates/azurerm/azurerm_resource_group"
  resource_group_name = var.resource_group_name
  location = var.location
}