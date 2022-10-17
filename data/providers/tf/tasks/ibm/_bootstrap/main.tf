terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}
provider "ibm" {
  region = "us-south"
}
module "bootstrap" {
  source = "../../../templates/ibm/_bootstrap"
  name   = var.name
}