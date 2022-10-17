locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}-ag"
}
module "virtual-network" {
  source              = "../azurerm_virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
  addresses           = var.address_space
}
module "public-ip" {
  source              = "../azurerm_public_ip"
  resource_group_name = var.resource_group_name
  location            = var.location
}
resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  address_prefixes     = var.subnets[count.index].address_prefixes
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.virtual-network.name
}
resource "azurerm_application_gateway" "this" {
  #depends_on=[azurerm_public_ip.pip]
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "sku" {
    for_each = var.sku
    content {
      name     = sku.value.name
      tier     = sku.value.tier
      capacity = sku.value.capacity
    }
  }
  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configuration
    content {
      name      = length(gateway_ip_configuration.value.name) > 0 ? gateway_ip_configuration.value.name : "${var.resource_group_name}-gipc"
      subnet_id = length(gateway_ip_configuration.value.subnet_id) > 0 ? gateway_ip_configuration.value.subnet_id : module.public-ip.id
    }
  }
  dynamic "frontend_port" {
    for_each = var.frontend_port
    content {
      name = length(frontend_port.value.name) > 0 ? frontend_port.value.name : "${var.resource_group_name}-feport"
      port = frontend_port.value.port
    }
  }
  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = module.public-ip.id
    }
  }
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool
    content {
      name = backend_address_pool.value.name
    }
  }
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                  = length(backend_http_settings.value.name) > 0 ? backend_http_settings.value.name : "${var.resource_group_name}-behs"
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      #path=backend_http_settings.value.path
      port     = backend_http_settings.value.port
      protocol = backend_http_settings.value.protocol
      #request_timeout=backend_http_settings.value.request_timeout
    }
  }
  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
    }
  }
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name               = request_routing_rule.value.name
      rule_type          = request_routing_rule.value.rule_type
      http_listener_name = request_routing_rule.value.http_listener_name
      #backend_address_pool_name=request_routing_rule.value.backend_address_pool_name
      #backend_http_settings_name=request_routing_rule.value.http_setting_name
      priority = request_routing_rule.value.priority
    }
  }
  tags = var.tags
}