##
# Module to build the Azure DevOps "seed" configuration
##
data "aws_caller_identity" "current" {}
# <Arn>arn:aws:iam::900045859038:user/DevOps</Arn>
# 2022-10-02T08:34:46.447-0500 [DEBUG] provider.terraform-provider-aws_v2.36.0_x4.exe:     <UserId>AIDA5DDXJ5DPPVMBEDSSB</UserId>
# 2022-10-02T08:34:46.447-0500 [DEBUG] provider.terraform-provider-aws_v2.36.0_x4.exe:     <Account>900045859038</Account>
data "aws_billing_service_account" "current" {}
#data aws_iam_account_alias current {}
#data aws_organizations_organization current {}
data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
locals {
  #name=replace((length(var.name != null ? var.name : "")>0 ? var.name : data.aws_caller_identity.current.arn),"/[^A-Za-z0-9]-/","")
  #name=replace((length(var.name != null ? var.name : "")>0 ? var.name : data.aws_iam_account_alias.current.account_alias),"/[^A-Za-z0-9]-/","")
  #name=replace((length(var.name != null ? var.name : "")>0 ? var.name : data.aws_organizations_organization.main.arn),"/[^A-Za-z0-9]-/","")
  #name=replace((length(var.name != null ? var.name : "")>0 ? var.name : data.aws_billing_service_account.current.arn),"/[^A-Za-z0-9]-/","")
  #name=replace((length(var.name != null ? var.name : "")>0 ? var.name : ""),"/[^A-Za-z0-9]-/","")
  name           = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  backend_bucket = replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "") > 0 ? var.backend_bucket : "${local.name}-backend-bucket"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
  backend_db     = replace(replace((length(var.backend_db != null ? var.backend_db : "") > 0 ? var.backend_db : "${local.name}-backend-db"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
module "aws_backend_bucket" {
  source = "../aws_s3_bucket"
  name   = local.backend_bucket
}
module "aws_dynamodb_table" {
  source = "../aws_dynamodb_table"
  name   = local.backend_db
}
# module write_files {
#   source="../../local/write_files"
#   files={"debug.txt"="user.account=${data.aws_caller_identity.current.account_id}\nuser.arn=${data.aws_caller_identity.current.arn}\nuser.id=${data.aws_caller_identity.current.user_id}\narn=${data.aws_billing_service_account.current.arn},\nid=${data.aws_billing_service_account.current.id}"} 
# }
module "aws_iam_group" {
  source = "../aws_iam_group"
  name   = var.group
  path   = "/"
}
module "aws_iam_group_policy_attachment" {
  source     = "../aws_iam_group_policy_attachment"
  name       = module.aws_iam_group.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}
module "aws_iam_user" {
  source = "../aws_iam_user"
  name   = "${var.group}-${local.name}"
}
module "aws_iam_user_group_membership" {
  source = "../aws_iam_user_group_membership"
  groups = [module.aws_iam_group.name]
  user   = module.aws_iam_user.name
}
module "aws_iam_user_login_profile" {
  source                  = "../aws_iam_user_login_profile"
  user                    = module.aws_iam_user.name
  password_reset_required = true
  pgp_key                 = "keybase:terraform_user"
}
module "aws_iam_access_key" {
  depends_on = [module.aws_iam_user]
  source     = "../aws_iam_access_key"
  user       = module.aws_iam_user.name
}
module "aws_iam_access_key_metadata" {
  depends_on = [module.aws_iam_access_key]
  source     = "../../local/write_files"
  files      = { "aws_iam_access_key_metadata.txt" = "AWS_ACCESS_KEY_ID=${module.aws_iam_access_key.id},\nAWS_ACCESS_KEY_ENCRYPTED_SECRET=${module.aws_iam_access_key.encrypted_secret},\nAWS_ACCESS_KEY_KEY_FINGERPRINT=${module.aws_iam_access_key.key_fingerprint},\nAWS_SECRET_ACCESS_KEY=${module.aws_iam_access_key.secret != null ? module.aws_iam_access_key.secret : ""}" }
}
module "set_env" {
  depends_on = [module.aws_iam_access_key]
  source     = "../../local/set_env"
  files      = { "set_env.txt" = "AWS_ACCESS_KEY_ID=${module.aws_iam_access_key.id},\nAWS_ACCESS_KEY_ID=${module.aws_iam_access_key.encrypted_secret},\nAWS_SECRET_ACCESS_KEY=${module.aws_iam_access_key.secret != null ? module.aws_iam_access_key.secret : ""}" }
}
