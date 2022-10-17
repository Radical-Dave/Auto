terraform {
  #experiments=[module_variable_optional_attrs]
  #aws-version="~> 2.36.0"
  #required_version=">=0.14"  
  #backend "s3" {
  #  bucket         = "your_globally_unique_bucket_name"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
}
provider "aws" {
  region = "us-east-1"
}
module "aws_s3_bucket" {
  source = "../../../templates/aws/aws_s3_bucket"
  name   = var.name
}