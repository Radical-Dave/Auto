resource "azurerm_dns_cname_record" "this" {
  name                = var.name #replace(var.name,".${var.dns_resource_group_name}",".www")
  ttl                 = var.ttl
  zone_name           = replace(var.zone_name, "api.", "")
  resource_group_name = var.dns_resource_group_name
  tags                = var.tags
  #record="${var.prefix != var.name && var.prefix != "dev" ? "${var.prefix}." : ""}${var.resource_group_name}.azurewebsites.net"
  record             = var.record
  target_resource_id = var.target_resource_id
}