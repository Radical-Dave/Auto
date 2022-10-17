resource "azurerm_dns_txt_record" "this" {
  name = "asuid.${var.name}"
  dynamic "record" {
    for_each = [for rec in var.record : { value = rec.value }]
    content { value = record.value.value }
  }
  resource_group_name = var.resource_group_name
  tags                = var.tags
  ttl                 = var.ttl
  zone_name           = replace(var.zone_name, "api.", "")
}