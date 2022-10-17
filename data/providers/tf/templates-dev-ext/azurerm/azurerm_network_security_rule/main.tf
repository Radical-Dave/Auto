locals {
  name                       = length(var.name != null ? var.name : "") > 0 ? (substr(var.name, 0, 1) != "~" ? var.name : "${var.resource_group_name}-${replace(var.name, "~", "")}-rule") : "${var.resource_group_name}-rule"
  access                     = length(var.access != null ? var.access : "") > 0 ? var.access : "Allow"
  direction                  = length(var.direction != null ? var.direction : "") > 0 ? var.direction : "Inbound"
  priority                   = length(var.priority != null ? var.priority : "") > 0 ? var.priority : "102"
  protocol                   = length(var.protocol != null ? var.protocol : "") > 0 ? var.protocol : "Tcp"
  source_address_prefix      = length(var.source_address_prefix != null ? var.source_address_prefix : "") > 0 ? var.source_address_prefix : var.name == "dmz" ? "Internet" : var.name == "web" ? "dmz-asg" : "web-asg"
  source_port_range          = length(var.source_port_range != null ? var.source_port_range : "") > 0 ? var.source_port_range : var.name == "sql" || var.name == "db" ? "1443" : "443"
  destination_address_prefix = length(var.destination_address_prefix != null ? var.destination_address_prefix : "") > 0 ? var.destination_address_prefix : var.name == "dmz" ? "Internet" : "${var.name}-asg"
  destination_port_range     = length(var.destination_port_range != null ? var.destination_port_range : "") > 0 ? var.destination_port_range : var.name == "sql" ? "1443" : "443"
  description                = length(var.description != null ? var.description : "") > 0 ? var.description : "${local.name}-rule: ${local.protocol}:${local.source_port_range}-${local.destination_port_range}-${local.direction}-${local.access}"
}
resource "azurerm_network_security_rule" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
  #location=var.location
  network_security_group_name                = var.network_security_group_name
  description                                = local.description
  protocol                                   = local.protocol
  destination_port_range                     = local.destination_port_range
  destination_address_prefix                 = local.destination_address_prefix
  destination_address_prefixes               = var.destination_address_prefixes
  destination_application_security_group_ids = var.destination_application_security_group_ids
  source_port_range                          = local.source_port_range
  source_address_prefix                      = local.source_address_prefix
  source_address_prefixes                    = var.source_address_prefixes
  source_application_security_group_ids      = var.source_application_security_group_ids
  # source_application_security_group_ids=[
  #   azurerm_network_security_group.bootstrap.id,
  #   azurerm_network_security_group.master.id,
  #   azurerm_network_security_group.worker.id,
  #   azurerm_network_security_group.api-lb.id
  # ]
  access    = local.access
  priority  = local.priority
  direction = local.direction
  #tags=var.tags  
}