data "external" "write_files" {
  program = ["python", "${path.module}/write-files.py"]
  query   = var.files
}