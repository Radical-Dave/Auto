terraform {
  #experiments=[module_variable_optional_attrs]
  #required_version=">=0.14"  
  #backend "s3" {
  #  bucket         = "your_globally_unique_bucket_name"
  #  key            = "terraform.tfstate"
  #  region         = "us-east-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
}
# provider oci { 
#   region="us-east-1"
#   #version="~> 2.36.0"
# }
# module gitops_site {
#   source="../../../templates/oci/_smoke_test"
#   backend_bucket=var.backend_bucket
#   name=var.name
# }
provider "oci" {
  #auth = var.auth #[ApiKey InstancePrincipal InstancePrincipalWithCerts SecurityToken ResourcePrincipal]
  #project = "{{YOUR GCP PROJECT}}"
  #region="us-central1"
  #zone="us-central1-c"

  region           = var.REGION
  tenancy_ocid     = var.TENANCY_OCID
  user_ocid        = var.USER_OCID
  fingerprint      = var.FINGERPRINT
  private_key_path = var.PRIVATE_KEY_PATH
}
# provider "oci" {
# }

#variable "tenancy_ocid" {}

# output "tenancy" {
#   value = data.oci_identity_tenancy.account
# }

# module "write_files" {
#   source = "../../../templates/local/write_files"
#   files  = { "debug.txt" = "var.private_key_path=${var.private_key_path}" }
# }

# module echo {
#   source="../../../templates/local/echo"
#   input=var.private_key_path
# }

# module echo {
#   source="../../../templates/_common/echo"
#   input=data.oci_identity_tenancy.account
# }

module "write_files_oci" {
  source = "../../../templates/local/write_files"
  files  = { "debug.oci.txt" = "private_key_path=${var.PRIVATE_KEY_PATH}\ntenancy_ocid=${var.TENANCY_OCID != null ? var.TENANCY_OCID : ""}" }
}
data "oci_identity_tenancy" "account" {
  tenancy_id = var.TENANCY_OCID
}