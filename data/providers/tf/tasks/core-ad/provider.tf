terraform {
  experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"  
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    #container_name  = "smoke-test-terraform"
    #key = "smoke-test-terraform.tfstate"
    #container_name = "base-terraform"
    container_name = "tfstate"
    #key = "core-dev-terraform.tfstate"
    key = "core-ad-terraform.tfstate"
  }
}
provider "azuread" {}
provider "azurerm" { 
  subscription_id = var.subscription_id
  features {}
}