locals {
  name = replace(length(var.name) > 0 ? (length(var.name) > 50 ? substr(var.name, 0,49) : var.name) : "${var.resource_group_name}-firewall", " ", "-")
}
resource "azurerm_firewall" "this" {
  depends_on=[azurerm_public_ip.azure_firewall_public_ip]
  name = local.name
  resource_group_name = var.resource_group_name
  location = var.location
  ip_configuration = {
    name = "hg-${var.region}-core-azure-firewall-config"
    subnet_id = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.azure_firewall_pip.id
  }
  tags = var.tags
}