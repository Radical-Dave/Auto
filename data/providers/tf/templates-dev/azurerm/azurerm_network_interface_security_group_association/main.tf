locals {
  network_interface_id = length(var.network_interface_id != null ? var.network_interface_id : "") > 0 ? var.network_interface_id : "${var.resource_group_name}-nic"
  nsg_id               = length(var.application_security_group_id != null ? var.application_security_group_id : "") > 0 ? var.application_security_group_id : "${var.resource_group_name}-nsg"
}
resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = local.network_interface_id
  network_security_group_id = var.application_security_group_id
}