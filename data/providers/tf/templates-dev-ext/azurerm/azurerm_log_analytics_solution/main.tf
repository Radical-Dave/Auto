locals {
  name = length(var.name) > 0 ? var.name : "${var.resource_group_name}-agw"
}
module "azurerm_log_analytics_workspace" {
  source              = "../../templates/azurerm/azurerm_log_analytics_workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
  #resource_group_name=module.resourcegroup.name
  #location=module.resourcegroup.location
}
resource "azurerm_log_analytics_solution" "this" {
  solution_name         = local.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = module.azurerm_log_analytics_workspace.id
  workspace_name        = module.azurerm_log_analytics_workspace.name
  dynamic "plan" {
    for_each = var.plan != null ? [true] : []
    content {
      publisher = var.plan.publisher
      product   = var.plan.product
      #promotion_code=var.plan.promotion_code
    }
  }
  tags = var.tags
}