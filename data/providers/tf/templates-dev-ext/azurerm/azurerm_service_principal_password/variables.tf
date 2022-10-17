variable "azuread_service_principal_id" {
  description = "The azuread_service_principal_id"
  type        = string
  default     = null
}
variable "enable_service_principal_certificate" {
  type        = bool
  description = "Manages a Certificate associated with a Service Principal within Azure Active Directory"
  default     = false
}
variable "password_end_date" {
  description = "The relative duration or RFC3339 rotation timestamp after which the password expire"
  default     = null
}
variable "password_rotation_years" {
  description = "Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password_end_date and either one is specified and not the both"
  default     = null
}
variable "password_rotation_days" {
  description = "Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation.Conflicts with `password_end_date`, `password_rotation_in_years` and either one must be specified, not all"
  default     = null
}