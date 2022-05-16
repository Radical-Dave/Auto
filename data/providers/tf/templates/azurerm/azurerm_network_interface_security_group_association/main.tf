locals {
  nic_id = length(var.nic_id) > 0 ? var.nic_id : "${var.resource_group_name}-nic"
  nsg_id = length(var.nsg_id) > 0 ? var.nsg_id : "${var.resource_group_name}-nsg"
}
resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id = local.nic_id
  network_security_group_id  = var.nsg_id
}