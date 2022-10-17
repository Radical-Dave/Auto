terraform {
  #experiments=[module_variable_optional_attrs]
  #required_version=">=0.14"  
  backend "s3" {
    bucket         = local.name
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
  #version="~> 2.36.0"
}
module "gitops_site" {
  source         = "../../../templates/aws/_gitops_site"
  backend_bucket = var.backend_bucket
  name           = var.name
}