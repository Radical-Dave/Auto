locals {
  name = replace(length(var.name != null ? var.name : "") > 0 ? (length(var.name != null ? var.name : "") > 50 ? substr(var.name, 0, 49) : var.name) : "${var.resource_group_name}-firewall", " ", "-")
}
resource "azurerm_firewall" "this" {
  #depends_on=[azurerm_public_ip.azure_firewall_public_ip]
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  ip_configuration {
    name                 = "AzureFirewallSubnet" #${local.name}-firewall-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
  tags = var.tags
}