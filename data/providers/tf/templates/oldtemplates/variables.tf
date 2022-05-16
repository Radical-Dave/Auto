variable "resourcegroup" {
  default       = "smoke-test-aks"
  description   = "Name of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resourcegroupprefix" {
  default       = "smoke-test-aks-rg-"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "location" {
  default = "eastus"
  description   = "Location of the resource group."
}