resource "auth0_organization" "this" {
  name         = var.name
  display_name = var.display_name
  branding {
    logo_url = var.logo_url
    colors = {
      primary         = var.colors_primary
      page_background = var.colors_background
    }
  }
  # deprecated-replaced with auth0_organization_connection
  # connections {
  #   connection_id=var.connection_id
  #   assign_membership_on_login=var.assign_membership_on_login
  # }
}