locals {
  name = length(var.name) > 0 ? (substr(var.name,0,1) != "~" ? var.name : "${var.resource_group_name}-${replace(var.name,"~","")}-asg") : "${var.resource_group_name}-asg"
}
resource "azurerm_application_security_group" "this" {
  resource_group_name = var.resource_group_name
  name      = local.name
  location  = var.location
  tags      = var.tags
}