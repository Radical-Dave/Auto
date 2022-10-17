variable "AUTH" {
  description = "The AUTH of the _smoke_test"
  type        = string
  default     = "APIKey" #"SecurityToken"
}
variable "CONFIG_FILE_PROFILE" {
  description = "The CONFIG_FILE_PROFILE of the _smoke_test"
  type        = string
  default     = "PROFILE"
}
variable "FINGERPRINT" {
  description = "The FINGERPRINT of the _smoke_test"
  type        = string
  default     = "{name}-tfstate"
}
variable "NAME" {
  description = "The name of the _smoke_test"
  type        = string
  default     = null
}
variable "PRIVATE_KEY_PATH" {
  description = "The PRIVATE_KEY_PATH of the _smoke_test"
  type        = string
  #default     = "./.oci/key.pem"
  default = "D:\repos\\PowerShell\\Auto\\data\\providers\\tf\\tasks\\oci\\_smoketest/.oci/key.pem"
}
variable "REGION" {
  description = "The REGION of the _smoke_test"
  type        = string
  default     = "{name}-tfstate"
}
variable "TENANCY_OCID" {
  description = "The TENANCY_OCID of the _smoke_test"
  type        = string
  default     = null
}
variable "USER_OCID" {
  description = "The USER_OCID of the _smoke_test"
  type        = string
  default     = "{name}-tfstate"
}