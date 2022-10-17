locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-wafpolicy"
}
resource "azurerm_web_application_firewall_policy" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  custom_rules        = var.custom_rules
  policy_settings     = var.policy_settings
  managed_rules       = var.managed_rules
}