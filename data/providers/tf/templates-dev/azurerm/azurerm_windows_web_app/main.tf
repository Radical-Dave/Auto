locals {
  connection_strings = length(var.connection_strings != null ? var.connection_strings : []) > 0 ? var.connection_strings : []
  name               = coalesce(var.name, length(coalesce(var.resource_group_name, "")) > 0 ? "${var.resource_group_name}-app" : "app")
}
resource "azurerm_windows_web_app" "this" {
  name                    = local.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  service_plan_id         = var.service_plan_id
  app_settings            = var.app_settings
  https_only              = var.https_only
  client_affinity_enabled = var.client_affinity_enabled
  dynamic "connection_string" {
    for_each = local.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  site_config {
    always_on = var.always_on
    application_stack {
      docker_container_name     = replace(var.docker_image, "${var.docker_registry}/", "")
      docker_container_registry = var.docker_registry
      docker_container_tag      = var.docker_image_tag
    }
    container_registry_use_managed_identity = "false"
    ftps_state                              = "Disabled"
    health_check_path                       = var.health_check_path
    http2_enabled                           = true
    scm_type                                = "VSO"
    worker_count                            = 3
    # dynamic "ip_restriction" {
    #   for_each=local.ip_restriction
    #   content {
    #     name=ip_restriction.name != null ? ip_restriction.name : null
    #     action=ip_restriction.action != null ? ip_restriction.action : null
    #     ip_address=ip_restriction.ip_address != null ? ip_restriction.ip_address : null          
    #     service_tag=ip_restriction.service_tag != null ? ip_restriction.service_tag : null
    #     priority=ip_restriction.priority != null ? ip_restriction.priority : null
    #     #description=ip_restriction.description != null ? ip_restriction.description : null
    #     #virtual_network_subnet_id=ip_restriction.virtual_network_subnet_id != null  ? ip_restriction.virtual_network_subnet_id : null
    #   }
    # }
  }
  tags = var.tags
}