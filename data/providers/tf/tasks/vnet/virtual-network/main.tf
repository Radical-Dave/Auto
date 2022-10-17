provider "azurerm" {
  version = "~>2.0"
}
terraform {
  backend "azurerm" {}
}
resource "azurerm_virtual_network" "test" {
  name                = "virtualNetwork1"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}