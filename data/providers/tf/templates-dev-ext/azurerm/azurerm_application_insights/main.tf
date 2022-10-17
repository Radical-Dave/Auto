locals {
  name = length(var.name) > 0 ? var.name : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}-ai" : "ai"
}
resource "azurerm_application_insights" "this" {
  application_type    = var.application_type #"Node.JS"
  disable_ip_masking  = true
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  retention_in_days   = 730
  workspace_id        = var.workspace_id
}