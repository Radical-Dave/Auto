locals {
  name = replace("asuid.${replace(length(var.name != null ? var.name : "") > 0 ? var.name : "${length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}." : ""}${var.resource_group_name}", ".azurewebsites.net", "")}", ".${var.resource_group_name}", "")
}
resource "azurerm_dns_txt_record" "this" {
  #name=length(regexall(".*..*", local.name)) > 0 ? "asuid.${split(".", local.name)[0]}" : "asuid"
  #name=local.name
  name = length(local.name != null ? local.name : "") > 0 ? local.name : "asuid.www"
  dynamic "record" {
    for_each = [for rec in var.record : { value = rec.value }]
    content { value = record.value.value }
  }
  resource_group_name = var.dns_resource_group_name
  ttl                 = var.ttl
  tags                = var.tags
  zone_name           = replace(var.zone_name, "api.", "")
}