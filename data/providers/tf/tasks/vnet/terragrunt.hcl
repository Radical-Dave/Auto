remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "crazyrg"
    }
}

inputs = {
  location = "eastus"
  resource_group_name = "crazyrg"
}