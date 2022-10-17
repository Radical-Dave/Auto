variable "ENVNAME" {
  description = "The ENVNAME of the _instance"
  type        = string
  default     = "dev"
}
variable "NAME" {
  description = "The NAME of the _instance"
  type        = string
  default     = null
}
variable "PREFIX" {
  description = "The PREFIX of the _instance"
  type        = string
  default     = "blessedbeyondfoundation"
}
variable "PROJECT" {
  description = "The PROJECT of the s3 bucket (Globally unique)"
  type        = string
  default     = "blessedbeyondfoundation-dev"
}
variable "REGION" {
  description = "The REGION of the s3 bucket (Globally unique)"
  type        = string
  default     = "us-central-1"
}
variable "ZONE" {
  description = "The ZONE of the s3 bucket (Globally unique)"
  type        = string
  default     = "us-central1-c"
}
