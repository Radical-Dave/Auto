locals {
  #name=replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0,63) : var.name) : "${var.resource_group_name}sa", " ", ""), "-", "")
  #name=substr(replace(replace(coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}sa" : "sa"), " ",""),"-",""),0,63)
  #name=replace(replace(replace(replace(length(var.name) > 64 ? substr(var.name, 0,63) : var.name, " ", "-"), "$",""), "(",""), ")","")
  #name=replace(replace(replace(replace(replace(substr(length(var.name != null ? var.name : "") > 0 ? var.name : "${var.resource_group_name}sa",0,24), " ", ""),"-", ""), "$",""), "(",""), ")","")
  #name=substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}sa" : "project${var.resource_group_name}sa": "projectsa",0,24),"-","")
  #name=substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-",var.resource_group_name)) > 1 ? "${var.resource_group_name}sa" : "project${var.resource_group_name}sa": "projectsa",0,24),"-","")
  name     = substr(length(var.name != null ? var.name : "") > 0 ? var.name : replace(length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? length(split("-", var.resource_group_name)) > 1 ? "${var.resource_group_name}sa" : "project${var.resource_group_name}sa" : "projectsa", "-", ""), 0, 24)
  location = length(var.location != null ? var.location : "") > 0 ? var.location : "eastus"
}
resource "azurerm_storage_account" "this" {
  name                     = substr(replace(local.name, "-", ""), 0, 24)
  location                 = local.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.sa_tier
  account_replication_type = var.sa_reptype
  tags                     = var.tags
}