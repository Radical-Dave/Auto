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
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.36.0"
}
locals {
  name = replace((length(var.name != null ? var.name : "") > 0 ? var.name : "Blessed Beyond Foundation"), "/[^A-Za-z0-9]-/", "")
}
module "aws_instance" {
  source = "../../../templates/aws/_instance"
  name   = local.name
}