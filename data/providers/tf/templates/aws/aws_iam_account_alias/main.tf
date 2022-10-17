locals {
  name          = replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0, 63) : var.name, " ", "-"), "$", ""), "(", ""), ")", "")
  account_alias = length(var.account_alias != null ? var.account_alias : "") > 0 ? var.account_alias : "needsomethingherefordefault"
}
resource "aws_iam_account_alias" "this" {
  account_alias = local.account_alias
}