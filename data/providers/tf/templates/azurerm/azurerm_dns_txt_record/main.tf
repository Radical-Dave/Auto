locals {
  #defaultdomain = length(var.defaultdomain) > 0 ? var.defaultdomain : "azurewebsites.net"
  #domain = length(var.domain) > 0 ? var.domain : local.defaultdomain
  #hostname = length(var.hostname) > 0 ? var.hostname : length(var.prefix) > 0 ? "${var.prefix}.${var.resource_group_name}.${local.domain}" : "${var.resource_group_name}.${local.domain}"
  #name = length(var.name) > 0 ? var.name : "asuid.${local.hostname}"
  #record = length(var.record) > 0 ? var.record : []
  #hostname = coalesce(var.hostname, "${var.resource_group_name}.${local.domain}")
  #hostname = length(var.hostname != null ? var.hostname : "") > 0 ? var.hostname : length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}.${var.resource_group_name}" : "${var.resource_group_name}"
  #hostname = length(var.hostname != null ? var.hostname : "") > 0 ? null : ${var.resource_group_name}" : var.resource_group_name
  #name = coalesce(var.name, "asuid.${local.hostname}")
  name = coalesce(var.name, "asuid.${length(var.prefix != null ? var.prefix : "") > 0 ? "${var.prefix}." : ""}${var.resource_group_name}")
  record = coalesce(var.record, [])
  #record = var.record != null ? var.record : [{value = "e3592717a03d7cfcf784651fe01e1d923caf9699c1b785a527ce713cf0f2fdcd"}]# "asuid.${local.name}-txt"}]
}
resource "azurerm_dns_txt_record" "this" {
  name = replace(local.name, ".azurewebsites.net", "")
  ttl = var.ttl
  zone_name = var.zone_name
  resource_group_name = var.dns_resource_group_name
  tags = var.tags
  dynamic "record" {
    for_each = local.record
    content {
      #value = record.value["value"]
      value = record.value
    }
  }
}