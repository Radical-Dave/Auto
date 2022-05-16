locals {
  name = coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}-nic" : "nic")
  location = coalesce(var.location, "eastus")
}
resource "azurerm_network_interface" "this" {
  name = local.name
  location = local.location
  resource_group_name = var.resource_group_name
  #network_security_group_id = var.network_security_group_id
  tags = var.tags
  dynamic "ip_configuration" {
    for_each = var.ip_configuration #!= null ? [true] : []
    content {
      name = ip_configuration.value.name
      subnet_id = ip_configuration.value.subnet_id
      primary = ip_configuration.value.primary
      private_ip_address = ip_configuration.value.private_ip_address
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id = ip_configuration.value.public_ip_address_id
    }
  }
  lifecycle {
    ignore_changes = [private_ip_address]
  }
}