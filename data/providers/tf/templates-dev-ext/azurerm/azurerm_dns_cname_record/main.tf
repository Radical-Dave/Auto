resource "azurerm_dns_cname_record" "this" {
  name                = var.name
  record              = var.record
  resource_group_name = var.resource_group_name
  tags                = var.tags
  target_resource_id  = var.target_resource_id
  ttl                 = var.ttl
  zone_name           = var.zone_name
}