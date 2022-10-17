locals {
  network_interface_id          = length(var.network_interface_id != null ? var.network_interface_id : "") > 0 ? var.network_interface_id : "${var.resource_group_name}-nic"
  application_security_group_id = length(var.application_security_group_id != null ? var.application_security_group_id : "") > 0 ? var.application_security_group_id : "${var.resource_group_name}-asg"
}
resource "azurerm_network_interface_application_security_group_association" "this" {
  network_interface_id          = local.network_interface_id
  application_security_group_id = local.application_security_group_id
  #ip_configuration_name=azurerm_network_interface.nic.ip_configuration[0].name  
}