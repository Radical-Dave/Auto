resource "aws_dynamodb_table" "this" {
  name         = var.name
  billing_mode = var.billing_mode

  # Hash key is required, and must be an attribute
  hash_key = "LockID"

  # Attribute LockID is required for TF to use this table for lock state
  attribute {
    name = "LockID"
    type = "S"
  }
  # tags = {
  #   Name=local.db_name
  #   BuiltBy="Terraform"
  # }
  tags = merge({ "Name" = format("%s", var.name) }, var.tags, var.tags_default)
}