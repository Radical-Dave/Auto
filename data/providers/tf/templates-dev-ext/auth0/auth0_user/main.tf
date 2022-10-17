resource "auth0_user" "this" {
  name         = var.name
  display_name = var.display_name
  branding {
    logo_url = var.logo_url
    colors = {
      primary         = var.colors_primary
      page_background = var.colors_background
    }
  }
  connections {
    connection_id              = var.connection_id
    assign_membership_on_login = var.assign_membership_on_login
  }
}