locals {
  defaultdomain = length(var.defaultdomain) > 0 ? var.defaultdomain : "azurewebsites.net"
  domain = length(var.domain) > 0 ? var.domain : local.defaultdomain
  hostname = length(var.hostname) > 0 ? var.hostname : "${var.resource_group_name}.${local.domain}"
}
resource "azurerm_dns_zone" "this" {
  name = local.hostname
  resource_group_name = var.resource_group_name
  tags = var.tags
}