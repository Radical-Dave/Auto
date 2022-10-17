resource "azurerm_app_service_source_control" "this" {
  app_id                 = var.app_id
  branch                 = var.branch
  repo_url               = var.repo_url
  rollback_enabled       = var.rollback_enabled
  use_manual_integration = var.use_manual_integration
  use_mercurial          = var.use_mercurial
}