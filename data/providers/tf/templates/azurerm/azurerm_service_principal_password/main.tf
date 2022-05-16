module "time-rotating" {
  source = "../../templates/time-rotating"
  end_date = var.password_end_date
  rotation_days = var.password_rotation_days
  rotation_years = var.password_rotation_years
}
resource "azuread_service_principal_password" "this" {
  count = var.enable_service_principal_certificate == false ? 1 : 0
  service_principal_id = var.azuread_service_principal_id
  rotate_when_changed = {
    rotation = module.time-rotating.id
  }
}