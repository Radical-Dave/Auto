terraform {
  # experiments = [module_variable_optional_attrs]
  required_version = ">=0.14.0"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    container_name       = "tfstate"
    #key = "core-devops-azure.tfstate"
  }
}

# Set envvars: AZDO_PERSONAL_ACCESS_TOKEN, AZDO_ORG_SERVICE_URL
provider "azuredevops" {
  org_service_url       = var.AZDO_URL
  personal_access_token = var.AZDO_PAT
}
provider "azuread" {
}
provider "azurerm" {
  features {
    #     # key_vault {
    #     #   purge_soft_delete_on_destroy = true
    #     # }
    #     # subscription_id = var.subscription_id    
  }
}