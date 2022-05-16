locals {
  nic_id = length(var.nic_id) > 0 ? var.nic_id : "${var.resource_group_name}-nic"
  asg_id = length(var.asg_id) > 0 ? var.asg_id : "${var.resource_group_name}-asg"
}
resource "azurerm_network_interface_application_security_group_association" "this" {
  network_interface_id = local.nic_id
  application_security_group_id = var.asg_id
  #ip_configuration_name = azurerm_network_interface.nic.ip_configuration[0].name  
}