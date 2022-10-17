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
  project = var.PROJECT
  region  = var.REGION
  zone    = var.ZONE
}
locals {
  envname = length(var.ENVNAME != null ? var.ENVNAME : "") > 0 ? var.ENVNAME : "dev"
  name    = replace(length(var.NAME != null ? var.NAME : "") > 0 ? var.NAME : "${local.prefix}-${local.envname}", "/[^A-Za-z0-9]-/", "")
  #name = replace((length(var.name != null ? var.name : "") > 0 ? var.name : "Blessed Beyond Foundation"), "/[^A-Za-z0-9]-/", "")
  prefix = length(var.PREFIX != null ? var.PREFIX : "") > 0 ? var.PREFIX : "blessed" #Release.DefinitionName  
}
module "_instance" {
  source = "../../../templates/google/_instance"
  name   = local.name
  #network_id = module.google_compute_subnetwork.id
  ## Install Flask
  #metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"
}