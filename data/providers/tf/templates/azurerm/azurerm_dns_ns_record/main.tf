locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-dns"
}
resource "azurerm_dns_ns_record" "this" {
  name = local.name
  records = var.records
  resource_group_name = var.resource_group_name
  ttl = var.ttl
  zone_name = var.zone_name
  tags = var.tags
}