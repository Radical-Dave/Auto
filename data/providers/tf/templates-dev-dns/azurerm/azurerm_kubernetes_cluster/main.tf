locals {
  name       = length(var.name) > 0 ? var.name : "${var.resource_group_name}-kv"
  dns_prefix = length(var.dns_prefix) > 0 ? var.dns_prefix : replace(replace(local.name, "-", ""), " ", "")
}
# module resourcegroup {
#   source="../../templates/resourcegroup"
#   resource_group_name=var.resource_group_name
#   location=module.resourcegroup.location
# }
module "azurerm_log_analytics_workspace" {
  source              = "../../templates/azurerm/azurerm_log_analytics_workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
  #resource_group_name=module.resourcegroup.name
  #location=module.resourcegroup.location
}
module "azurerm_log_analytics_solution" {
  source = "../../templates/azurerm/azurerm_log_analytics_solution"
  #resource_group_name=module.resourcegroup.name
  #location=module.resourcegroup.location
  resource_group_name   = var.resource_group_name
  location              = var.location
  workspace_resource_id = module.azurerm_log_analytics_workspace.id
  workspace_name        = module.azurerm_log_analytics_workspace.name
}
resource "azurerm_kubernetes_cluster" "this" {
  name = local.name
  #resource_group_name=module.resourcegroup.name
  #location=module.resourcegroup.location
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = local.dns_prefix
  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider
    content {
      # address=key_vault_secrets_provider.value.address
      #add_address_to_env=key_vault_secrets_provider.value.add_address_to_env
      #token=key_vault_secrets_provider.value.token
      #token_name=key_vault_secrets_provider.value.token_name
    }
  }
  tags = var.tags
  # linux_profile {
  #   admin_username="ubuntu"
  #   ssh_key {
  #     key_data=file(var.ssh_public_key)
  #   }
  # }
  # identity {
  #   type="SystemAssigned"
  # }
  default_node_pool {
    name       = "agentpool" #default
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  # addon_profile {
  #   oms_agent {
  #     enabled=true
  #     log_analytics_workspace_id=module.azurerm_log_analytics_workspace.id
  #   }
  # }
  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }
}