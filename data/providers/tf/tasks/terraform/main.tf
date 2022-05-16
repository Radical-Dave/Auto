provider "azurerm" {
  region = "eastus"
}
terraform {
    backend "azurerm" {
      resource_group_name = "base-terraform-rg"
      storage_account_name = "baseterraformsa"
      container_name  = "base-terraform"
      key = "base-terraform.tfstate"      
    }
}

resource "azurerm_resource_group" "legacy-resource-group" {}

module "resourcegroup" {
  source = "../../templates/resourcegroup"  
}
module "storageaccount" {
  source = "../../templates/storageaccount"  
}