 terraform {
  experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    #container_name  = "smoke-test-terraform"
    #key = "smoke-test-terraform.tfstate"
    #container_name = "dev-terraform"
    container_name = "tfstate"
    #key = "core-dev-terraform.tfstate"
    #key = "peregrine-terraform.tfstate"
    key = "smoke-test-terraform/smoke-test.tfstate"
  }
}
provider "azurerm" { 
  subscription_id = var.subscription_id
  features {}
}