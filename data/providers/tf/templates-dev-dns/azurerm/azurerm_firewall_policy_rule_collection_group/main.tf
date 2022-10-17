locals {
  fprcp_name = replace((length(var.vnet_name) > 50 ? substr(var.vnet_name, 0, 49) : var.vnet_name), " ", "-")
}
resource "azurerm_firewall_policy_rule_collection_group" "this" {
  depends_on          = [azurerm_public_ip.azure_firewall_public_ip]
  name                = local.fprcg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_configuration {
    name                 = "hg-${var.region}-core-azure-firewall-config"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.azure_firewall_pip.id
  }
  tags = var.tags
}