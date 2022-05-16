remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "RemoveTerraform"
        storage_account_name = "terraformdevsa"
        container_name = "tfstate"
    }
}

inputs = {
    location = "eastus"
    resource_group_name = "testResourceGroup1-10"
}