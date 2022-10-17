resource "local_sensitive_file" "this" {
  content              = var.content
  content_base64       = var.content_base64
  directory_permission = var.directory_permission
  filename             = var.filename
  file_permission      = var.file_permission
  sensitive_content    = var.sensitive_content
  source               = var.source_file
}