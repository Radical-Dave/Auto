terraform {
  #experiments=[module_variable_optional_attrs]
}
locals {
  name      = length(var.name != null ? var.name : "") > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-nsg" : "nsg"
  nsg_rules = length(var.nsg_rules) > 0 ? var.nsg_rules : {} #tomap(object({destination_application_security_group_ids="${var.asgs}" }))
  #resource_group_name=length(var.resource_group_name) > 0 ? var.resource_group_name : "${var.resource_group_name}-nsg"
  # default={
  #   sql={
  #     name=""
  #     priority=100
  #     direction="Inbound"
  #     access="Allow"
  #     protocol="Tcp"
  #     source_port_range="*"
  #     #destination_port_range="1433"
  #     #source_address_prefix="SqlManagement"
  #     #destination_address_prefix="192.168.2.0/24"
  #     #source_address_prefix=      
  #   }
  #   http={
  #     name=""
  #     priority=101
  #     direction="Inbound"
  #     access="Allow"
  #     protocol="Tcp"
  #     source_port_range="*"
  #     destination_port_range="80" #443
  #     source_address_prefix="*"
  #     destination_address_prefix="192.168.2.0/24"
  #   }
  # }
}
resource "azurerm_network_security_group" "this" {
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
module "azurerm_network_security_rule" {
  source                      = "../azurerm_network_security_rule"
  for_each                    = var.nsg_rules
  name                        = each.key
  network_security_group_name = each.key

  access                                     = each.value.access
  destination_port_range                     = each.value.destination_port_range
  destination_address_prefix                 = each.value.destination_address_prefix
  destination_address_prefixes               = each.value.destination_address_prefixes
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  direction                                  = each.value.direction
  location                                   = each.value.location
  priority                                   = each.value.priority
  protocol                                   = each.value.protocol
  resource_group_name                        = var.resource_group_name
  source_port_range                          = each.value.source_port_range
  source_address_prefix                      = each.value.source_address_prefix
  source_address_prefixes                    = each.value.source_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
}