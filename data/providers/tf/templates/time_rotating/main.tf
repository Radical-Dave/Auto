locals {
  end_date = try(var.end_date, time_offset.today.rfc3339)
  rotation_years = var.rotation_years != null || var.rotation_months != null || var.rotation_minutes != null || var.rotation_days != null ? var.rotation_years : 1
}
resource "time_offset" "today" {
  offset_days = 0
}
resource "time_rotating" "this" {
  rotation_rfc3339 = local.end_date
  rotation_days = var.rotation_days
  rotation_minutes = var.rotation_minutes
  rotation_months = var.rotation_months
  rotation_years = local.rotation_years

  triggers = {
    end_date = var.end_date
    days = var.rotation_days
    minutes = var.rotation_minutes
    months = var.rotation_months
    years = local.rotation_years
  }
}