terraform {
  # backend "azurerm" {
  #   resource_group_name = "base-terraform-rg"
  #   storage_account_name = "baseterraformsa"
  #   container_name = "tfstate"
  #   key = "core-devops-azure.tfstate"
  # }
  # experiments = [module_variable_optional_attrs]
  # required_version = ">=0.14.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
}
provider "azuread" {}
provider "azuredevops" {
  org_service_url       = var.AZDO_URL
  personal_access_token = var.AZDO_PAT
}
