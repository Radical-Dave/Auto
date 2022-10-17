locals {
  #name = length(var.name) > 0 ? var.name : "project" # appName? #"${var.resource_group_name}-kvk"
  #vault_name = length(var.vault_name) > 0 ? var.vault_name : "${var.resource_group_name}-kv"
  #vault_resource_group = length(var.vault_resource_group) > 0 ? var.vault_resource_group : length(var.resource_group_name) > 0 ? "${var.resource_group_name}-rg" : "base-terraform-rg"
  domain_name = data.azuread_domains.default.domains.0.domain_name
  users       = csvdecode(file("${path.module}/users.csv"))
}
data "azuread_domains" "default" {
  only_initial = true
}
# data azurerm_key_vault key_vault {
#   name = local.vault_name
#   resource_group_name = local.vault_resource_group
# }
# data azurerm_key_vault_secret ad_app {
#   name = var.app_sp
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }
# data external app_sp {
#   program = [
#     #"echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#     "echo", "${base64decode(data.azurerm_key_vault_secret.ad_app.value)}"
#   ]
# }

resource "azuread_user" "users" {
  for_each              = { for user in local.users : user.first_name => user }
  department            = each.value.department
  display_name          = "${each.value.first_name} ${each.value.last_name}"
  force_password_change = true
  given_name            = each.value.first_name
  job_title             = each.value.job_title
  mail                  = each.value.mail
  password = format(
    "%s%s%s%s!",
    lower(each.value.last_name),
    substr(lower(each.value.first_name), 0, 1),
    length(each.value.first_name),
    lower(each.value.department)
  )
  surname             = each.value.last_name
  user_principal_name = each.value.principal #david.walker_revunit.com#EXT#@project.onmicrosoft.com  
  # user_principal_name = format(
  #   "%s.%s@%s",
  #   lower(each.value.first_name),
  #   lower(each.value.last_name),
  #   local.domain_name
  # )  
}

# module azuread_group {
#   source = "../../templates/azuread/azuread_group"
#   name = "it"
# }

# module azuread_group_dev {
#   source = "../../templates/azuread/azuread_group"
#   name = "dev"
# }