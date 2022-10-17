resource "auth0_connection" "this" {
  name                 = var.name
  is_domain_connection = var.is_domain_connection
  strategy             = "auth0"
  enabled_clients      = var.enabled_clients
  # metadata={
  #   key1="foo"
  #   key2="bar"
  # }
  options {
    brute_force_protection = true
    # configuration={
    #   foo="bar"
    #   bar="baz"
    # }
    custom_scripts = {
      get_user = <<EOF
function getByEmail (email, callback) {
  return callback(new Error("Whoops!"))
}
EOF
    }
    disable_signup                 = false
    enabled_database_customization = true
    import_mode                    = false
    mfa {
      active                 = true
      return_enroll_settings = true
    }
    # password_policy="excellent"
    # password_history {
    #   enable=true
    #   size=3
    # }
    # password_no_personal_info {
    #   enable=true
    # }
    # password_dictionary {
    #   enable=true
    #   dictionary=["password", "admin", "1234"]
    # }
    # password_complexity_options {
    #   min_length=12
    # }
    # validation {
    #   username {
    #     min=10
    #     max=40
    #   }
    # }
    requires_username = false
    upstream_params = jsonencode({
      "screen_name" : {
        "alias" : "login_hint"
      }
    })
  }
}