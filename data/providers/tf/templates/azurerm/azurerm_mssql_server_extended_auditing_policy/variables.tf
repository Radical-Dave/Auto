variable "enabled" {
  description = "The enabled of the azurerm_mssql_server_extended_auditing_policy server"
  type        = bool
  default     = true
}
variable "log_monitoring_enabled" {
  description = "The storage_account_access_key_is_secondary of the azurerm_mssql_server_extended_auditing_policy server"
  type        = bool
  default     = true
}
variable "retention_in_days" {
  description = "The retention_in_days of the azurerm_mssql_server_extended_auditing_policy server"
  type        = number
  default     = 7
}
variable "server_id" {
  description = "The server_id of the azurerm_mssql_server_extended_auditing_policy server"
  type        = string
}
variable "storage_endpoint" {
  description = "The storage_endpoint of the azurerm_mssql_server_extended_auditing_policy server"
  type        = string
}
variable "storage_account_access_key" {
  description = "The storage_account_access_key of the azurerm_mssql_server_extended_auditing_policy server"
  type        = string
  default     = null
}
variable "storage_account_access_key_is_secondary" {
  description = "The storage_account_access_key_is_secondary of the azurerm_mssql_server_extended_auditing_policy server"
  type        = bool
  default     = false
}