resource "aws_s3_bucket" "this" {
  bucket        = var.name
  bucket_prefix = var.bucket_prefix
  server_side_encryption_configuration { # Tells AWS to encrypt the S3 bucket at rest by default
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  # lifecycle {# Prevents Terraform from destroying or replacing this object - a great safety mechanism
  #   prevent_destroy=true
  # }
  versioning { # Tells AWS to keep a version history of the state file
    enabled = var.versioning
  }
  tags = merge({ "Name" = format("%s", var.name != null ? var.name : "") }, var.tags, var.tags_default)
}