resource "github_team" "this" {
  create_default_maintainer = var.create_default_maintainer
  description               = var.description
  ldap_dn                   = var.ldap_dn
  name                      = var.name
  parent_team_id            = var.parent_team_id
  privacy                   = var.privacy
}