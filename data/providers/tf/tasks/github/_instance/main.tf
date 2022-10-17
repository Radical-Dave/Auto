terraform {
  #experiments=[module_variable_optional_attrs]
  required_version = ">=0.14"
  #backend "s3" {
  #  bucket         = "your_globally_unique_bucket_name"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
}
provider "google" {
  project = ""
  region  = "us-central-1"
  zone    = "us-central1-c"
}
locals {
  name = replace((length(var.name != null ? var.name : "") > 0 ? var.name : "Blessed Beyond Foundation"), "/[^A-Za-z0-9]-/", "")
}
module "google_compute_instance" {
  source = "../../../templates/google/_instance"
  name   = local.name
}