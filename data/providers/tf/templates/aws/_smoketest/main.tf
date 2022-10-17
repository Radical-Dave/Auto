data "aws_region" "current" {}

module "local_file_debug" {
  source   = "../../../templates/local/local_file"
  content  = "region=${data.aws_region.current.name}"
  filename = "debug.txt"
}

module "write_files_debug" {
  source = "../../../templates/local/write_files"
  files  = { "debug.txt" = "region=${data.aws_region.current.name}" }
}