terraform {  
  # backend "azurerm" {
  #   resource_group_name = "base-terraform-rg"
  #   storage_account_name = "baseterraformsa"
  #   container_name = "tfstate"
  #   key = "core-devops-azure.tfstate"
  # }
  # experiments = [module_variable_optional_attrs]
  required_version = ">=0.14.0"
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Set envvars: AZDO_PERSONAL_ACCESS_TOKEN, AZDO_ORG_SERVICE_URL
provider "azuredevops" {
  org_service_url = var.azdo_org_service_url
  personal_access_token = var.azdo_personal_access_token
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