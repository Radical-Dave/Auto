terraform {
  required_version = ">=0.14"  
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
}
provider "azuredevops" {
  org_service_url = var.azdo_org_service_url
  personal_access_token = var.azdo_personal_access_token
}