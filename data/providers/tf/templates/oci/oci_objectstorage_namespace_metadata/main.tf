locals {
  #backend_bucket=replace(replace((length(var.backend_bucket != null ? var.backend_bucket : "")>0 ? var.backend_bucket : "${local.name}-tfstate-bucket"),"{name}",local.name),"/[^A-Za-z0-9]-/","")
  name      = lower(replace((length(var.name != null ? var.name : "") > 0 ? var.name : "BlessedBeyondFoundation"), "/[^A-Za-z0-9]-/", ""))
  namespace = replace(replace((length(var.namespace != null ? var.namespace : "") > 0 ? var.namespace : "${local.name}-namespace"), "{name}", local.name), "/[^A-Za-z0-9]-/", "")
}
resource "oci_objectstorage_namespace_metadata" "this" {
  access_type           = var.bucket_access_type
  auto_tiering          = var.bucket_auto_tiering
  compartment_id        = var.compartment_id
  defined_tags          = var.defined_tags  #{"Operations.CostCenter"= "42"}
  freeform_tags         = var.freeform_tags #{"Department"= "Finance"}
  kms_key_id            = var.kms_key_id
  metadata              = var.metadata
  name                  = local.name
  namespace             = local.namespace
  object_events_enabled = var.object_events_enabled
  storage_tier          = var.storage_tier
  retention_rules {
    display_name = var.retention_rule_display_name
    duration {
      #Required
      time_amount = var.retention_rule_duration_time_amount
      time_unit   = var.retention_rule_duration_time_unit
    }
    time_rule_locked = var.retention_rule_time_rule_locked
  }
  versioning = var.bucket_versioning
  #tags=merge({"Name"=format("%s", var.name)},var.tags,var.tags_default)
}