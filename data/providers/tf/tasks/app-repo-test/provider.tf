terraform {
  #experiments=[module_variable_optional_attrs]
  #required_version=">=0.14"  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    container_name       = "tfstate"
  }
}
#provider azuread {}
provider "azurerm" {
  # subscription_id=var.subscription_id
  features {}
}
# provisioner "local-exec" {
#   when="destroy"
#   command="az login --service-principal -u ${var.clientId} -p ${var.clientPassword} --tenant ${var.tenantId} && az resource delete --ids ${self.outputs.id}"
# }