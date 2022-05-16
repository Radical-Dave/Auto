locals {
  #name = replace(replace(length(var.name) > 0 ? (length(var.name) > 64 ? substr(var.name, 0,63) : var.name) : "${var.resource_group_name}sa", " ", ""), "-", "")
  name = substr(replace(replace(coalesce(var.name, length(coalesce(var.resource_group_name,""))>0 ? "${var.resource_group_name}sa" : "sa"), " ",""),"-",""),0,63)
  location = coalesce(var.location, "eastus")
}
resource "azurerm_storage_account" "this" {
  name = local.name
  location = local.location
  resource_group_name = var.resource_group_name  
  account_tier = var.sa_tier
  account_replication_type = var.sa_reptype
  tags = var.tags
}