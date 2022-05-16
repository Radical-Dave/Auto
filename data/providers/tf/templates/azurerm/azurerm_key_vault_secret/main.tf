locals {
  name = length(var.name) > 0 ? var.name : "peregrine" # appName? #"${var.resource_group_name}-kvk"
  vault_name = length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}kv"
}

resource "azurerm_key_vault_secret" "this" {
  name = local.name
  key_vault_id = local.vault_name
  vault_uri = "https://${local.vault_name}.vault.azure.net/"  
}

data "external" "app-sp-json" {
  program = [
    "echo",
    "${base64decode(data.azurerm_key_vault_secret.this.value)}"
  ]
}

output "app-sp" {
  value = "${data.external.app-sp-json.result}"
}