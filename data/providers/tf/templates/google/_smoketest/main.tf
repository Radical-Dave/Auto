data "google_client_config" "this" {}
module "write_files" {
  source = "../../../templates/local/write_files"
  files  = { "debug.txt" = "region=${data.google_client_config.this.region}\nproject=${data.google_client_config.this.region}" }
}
