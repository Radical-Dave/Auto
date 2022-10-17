variable "auth" {
  description = "The auth of the _smoke_test"
  type        = string
  default     = ""
}
variable "backend_bucket" {
  description = "The backend_bucket of the _smoke_test"
  type        = string
  default     = "{name}-backend-bucket"
}
variable "db_name" {
  description = "The subscription_id of the _smoke_test"
  type        = string
  default     = "{name}-tfstate"
}
variable "FINGERPRINT" {
  description = "The FINGERPRINT of the _smoke_test"
  type        = string
  default     = "{name}-tfstate"
}
variable "name" {
  description = "The name of the _smoke_test"
  type        = string
  default     = null
}
# variable s3_name {
#   description="The name of the _smoke_test"
#   type=string
#   default="{name}-tfstate"
# }
variable "PRIVATE_KEY_PATH" {
  description = "The PRIVATE_KEY_PATH of the _smoke_test"
  type        = string
  default     = "./.oci/key.pem"
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