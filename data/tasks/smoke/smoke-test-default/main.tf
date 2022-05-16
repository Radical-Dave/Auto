terraform {
  required_version = ">=0.12"  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  tenant_id = ""
  skip_provider_registration = true
  features {}
}
