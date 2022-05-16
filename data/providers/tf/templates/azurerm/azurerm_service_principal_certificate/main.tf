module "time-rotating" {
  source = "../../templates/time-rotating"
  end_date = var.password_end_date
  rotation_days = var.password_rotation_days
  rotation_years = var.password_rotation_years
}
resource "azuread_service_principal_certificate" "this" {
  count = var.enable_service_principal_certificate == true ? 1 : 0  
  encoding = var.certificate_encoding
  end_date = module.time-rotating.id  
  key_id = var.key_id
  service_principal_id = var.azuread_service_principal_id
  type = var.certificate_type
  value = file(var.certificate_path)  
}