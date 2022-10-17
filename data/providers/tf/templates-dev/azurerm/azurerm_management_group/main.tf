resource "azurerm_management_lock" "this" {
  name       = var.name
  location   = var.location
  scope      = var.id         # azurerm_key_vault.sp_creds_kv.id
  lock_level = var.lock_level #"CanNotDelete"
  notes      = var.notes      #"Locked because it's needed by Azure DevOps"
  tags       = var.tags
}