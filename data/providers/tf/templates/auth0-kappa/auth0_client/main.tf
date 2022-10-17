resource "auth0_client" "this" {
  allowed_logout_urls                 = var.allowed_logout_urls
  allowed_origins                     = var.allowed_origins
  app_type                            = var.app_type
  callbacks                           = var.callbacks
  cross_origin_auth                   = var.cross_origin_auth
  custom_login_page_on                = var.custom_login_page_on
  description                         = var.description
  grant_types                         = var.grant_types
  is_first_party                      = var.is_first_party
  is_token_endpoint_ip_header_trusted = var.is_token_endpoint_ip_header_trusted
  logo_uri                            = var.logo_uri
  name                                = var.name
  oidc_conformant                     = var.oidc_conformant
  organization_require_behavior       = "pre_login_prompt"
  organization_usage                  = "require"
  sso                                 = "false"
  sso_disabled                        = "false"
  token_endpoint_auth_method          = var.token_endpoint_auth_method
  web_origins                         = var.web_origins
  jwt_configuration {
    alg                 = "RS256"
    lifetime_in_seconds = var.id_token_expiration
    secret_encoded      = true
    #scopes = {foo="bar"}
  }
  # client_metadata = {
  #   foo="zoo"
  # }
  # addons {
  #   firebase = {
  #     client_email="john.doe@example.com"
  #     lifetime_in_seconds=1
  #     private_key="wer"
  #     private_key_id="qwreerwerwe"
  #   }
  #   samlp {
  #     audience="https://example.com/saml"
  #     mappings={
  #       email="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  #       name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
  #     }
  #     create_upn_claim=false
  #     passthrough_claims_with_no_mapping =false
  #     map_unknown_claims_as_is=false
  #     map_identities=false
  #     name_identifier_format="urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"
  #     name_identifier_probes=[
  #       "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  #     ]
  #     signing_cert="-----BEGIN PUBLIC KEY-----\nMIGf...bpP/t3\n+JGNGIRMj1hF1rnb6QIDAQAB\n-----END PUBLIC KEY-----\n"
  #   }
  # }
  # mobile {
  #   ios {
  #     team_id="9JA89QQLNQ"
  #     app_bundle_identifier="com.my.bundle.id"
  #   }
  # }
  refresh_token {
    expiration_type              = "expiring"
    idle_token_lifetime          = var.idle_token_lifetime
    infinite_idle_token_lifetime = "false"
    infinite_token_lifetime      = "false"
    leeway                       = 0
    rotation_type                = "rotating"
    token_lifetime               = var.refresh_token_lifetime
  }
}