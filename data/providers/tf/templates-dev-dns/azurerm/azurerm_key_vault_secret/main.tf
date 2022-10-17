locals {
  name         = length(var.name != null ? var.name : "") > 0 ? replace(replace(var.name, "_", "-"), " ", "-") : "azdevops" # appName? #"${var.resource_group_name}-kvk"
  key_vault_id = length(var.key_vault_id != null ? var.key_vault_id : "") > 0 ? var.key_vault_id : length(var.resource_group_name != null ? var.resource_group_name : "") > 0 ? "${var.resource_group_name}kv" : "base-terraform-kv"
}
resource "azurerm_key_vault_secret" "this" {
  name         = local.name
  key_vault_id = local.key_vault_id
  value        = var.value
}
# data external app-sp-json {
#   program=[
#     "echo",
#     "${base64decode(data.azurerm_key_vault_secret.this.value)}"
#   ]
# }

# output "app-sp" {
#   value="${data.external.app-sp-json.result}"
# }