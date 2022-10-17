resource "auth0_connection" "this" {
  display_name = length(var.display_name != null ? var.display_name : "") > 0 ? var.display_name : length(var.name) > 0 ? replace(var.name, "-users", "") : ""
  #brute_force_protection=var.brute_force_protection
  enabled_clients      = var.enabled_clients
  is_domain_connection = var.is_domain_connection
  name                 = var.name
  options {
    password_policy                = "good"
    brute_force_protection         = false
    enabled_database_customization = false
    import_mode                    = false
    requires_username              = false
    disable_signup                 = false
    # custom_scripts = {
    #   get_user = <<EOF
    #     function getByEmail(email, callback) {
    #       return callback(new Error("Whoops!"));
    #     }
    #   EOF
    # }
    # configuration = {
    #   foo = "bar"
    #   bar = "baz"
    # }
    # upstream_params = jsonencode({
    #   "screen_name" : {
    #     "alias" : "login_hint"
    #   }
    # })

    # password_history {
    #   enable = true
    #   size   = 3
    # }

    # password_no_personal_info {
    #   enable = true
    # }

    # password_dictionary {
    #   enable     = true
    #   dictionary = ["password", "admin", "1234"]
    # }

    password_complexity_options {
      min_length = 12
    }

    validation {
      username {
        min = 10
        max = 40
      }
    }

    mfa {
      active                 = true
      return_enroll_settings = true
    }
  }
  strategy = var.strategy
}