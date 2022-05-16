terraform {  
  backend "azurerm" {
    resource_group_name = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    container_name = "tfstate"
    key = "core-devops-azure.tfstate"
  }
  experiments = [module_variable_optional_attrs]
  required_version = ">=0.14.0"
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id  
  features {}
}