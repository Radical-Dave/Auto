terraform {
  required_version = ">=0.14"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
}
provider "azuredevops" {
  org_service_url       = var.AZDO_URL
  personal_access_token = var.AZDO_PAT
}