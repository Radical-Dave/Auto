terraform {
  #experiments=[module_variable_optional_attrs]
  #required_version=">=0.14"  
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    # auth0={
    #   source="auth0/auth0"
    #   version="~> 0.36.0"
    # }
    #azurerm={
    #  source="hashicorp/azurerm"
    #  version="3.0"
    #}
  }
  #backend "azurerm" {
  #  resource_group_name="base-terraform-rg"
  #  storage_account_name="baseterraformsa"
  #  container_name="tfstate"
  #}
}
# provider auth0 {  
#   client_id=var.AUTH0_CLIENT_ID
#   client_secret=var.AUTH0_CLIENT_SECRET
#   debug=true
#   domain=var.AUTH0_DOMAIN
# }
#provider azuread {}
#provider azurerm { 
#  # subscription_id=var.subscription_id
#  features {}
#}
# provisioner "local-exec" {
#   when="destroy"
#   command="az login --service-principal -u ${var.clientId} -p ${var.clientPassword} --tenant ${var.tenantId} && az resource delete --ids ${self.outputs.id}"
# }