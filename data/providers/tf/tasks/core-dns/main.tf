terraform {
  #experiments = [module_variable_optional_attrs]
  required_version = ">=0.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "base-terraform-rg"
    storage_account_name = "baseterraformsa"
    #container_name  = "smoke-test-terraform"
    #key = "smoke-test-terraform.tfstate"
    container_name = "base-terraform"
    #key = "core-dev-terraform.tfstate"
    key = "core-dns-terraform.tfstate"
  }
}
provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
locals {
  #name = length(var.name) > 0 ? var.name : "project" # appName? #"${var.resource_group_name}-kvk"
  vault_name           = length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  vault_resource_group = length(var.vault_resource_group) > 0 ? var.vault_resource_group : length(var.resource_group_name) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
}
data "azurerm_key_vault" "key_vault" {
  name                = local.vault_name
  resource_group_name = local.vault_resource_group
}
data "azurerm_key_vault_secret" "ad_app" {
  name         = var.app_sp
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
# data external app_sp {
#   program = [
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     "echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#   ]
# }

module "azurerm_resource_group" {
  source   = "../../templates/azurerm/azurerm_resource_group"
  name     = var.resource_group_name
  location = var.location
}

#if using cloudflare, they do have terraform provider: https://registry.terraform.io/providers/cloudflare/cloudflare/latest
module "azurerm_dns_zone" {
  source              = "../../templates/azurerm/azurerm_dns_zone"
  defaultdomain       = var.defaultdomain
  resource_group_name = module.azurerm_resource_group.name
}
module "azurerm_dns_txt_record" {
  source              = "../../templates/azurerm/azurerm_dns_txt_record"
  name                = "project.com"
  zone_name           = module.azurerm_dns_zone.name
  resource_group_name = module.azurerm_resource_group.name
  hostname            = module.azurerm_dns_zone.hostname
  #target_resource_id  = module.azurerm_public_ip.id
  record = var.record
}
# module azurerm_dns_a_record {
#   source = "../../templates/azurerm/azurerm_dns_zone"
#   name = "core.project.com"
#   zone_name = module.azurerm_dns_zone.name  
#   resource_group_name = module.azurerm_resource_group.name
#   target_resource_id  = module.azurerm_public_ip.id 
# }
module "azurerm_dns_a_record" {
  source              = "../../templates/azurerm/azurerm_dns_zone"
  name                = "core.project.com"
  records             = ["192.249.120.223"]
  resource_group_name = module.azurerm_resource_group.name
  #target_resource_id  = module.azurerm_public_ip.id
  zone_name = module.azurerm_dns_zone.name
}
# module azurerm_dns_ns_record {
#   source = "../../templates/azurerm/azurerm_dns_zone"
#   name = "core.project.com"
#   records = ["192.249.120.223"]
#   resource_group_name = module.azurerm_resource_group.name
#   #target_resource_id  = module.azurerm_public_ip.id
#   zone_name = module.azurerm_dns_zone.name  
# }