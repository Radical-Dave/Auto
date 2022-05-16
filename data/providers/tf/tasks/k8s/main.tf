provider "azurerm" {
  region = "us east"
}
module "azurerm_kubernetes_cluster" {
  source = "../../templates/azurerm/azurerm_kubernetes_cluster"  
}