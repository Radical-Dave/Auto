variable "content" {
  type    = string
  default = null
}
variable "content_base64" {
  type    = string
  default = null
}
variable "directory_permission" {
  type    = string
  default = "0777"
}
variable "filename" {
  type = string
}
variable "file_permission" {
  type    = string
  default = "0777"
}
variable "sensitive_content" {
  type    = string
  default = null
}
variable "source_file" {
  type    = string
  default = null
}